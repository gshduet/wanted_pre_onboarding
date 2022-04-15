import json
import re
import bcrypt
import jwt

from django.http     import JsonResponse
from django.views    import View
from django.db       import transaction

from config.settings import SECRET_KEY, ALGORITHM
from users.models    import User


class SignUpView(View):
    @transaction.atomic()
    def post(self, request):
        try:
            data     = json.loads(request.body)
            name     = data['name']
            password = data['password']

            # 유저가 사용하고자 하는 아이디를 정규식을 통해 검증
            # 알파벳으로 시작하며 알파벳, 숫자, 일부 특수문자('-', '_', '.')을 포함한 8~15자 사용가능
            if not re.match('^[a-zA-Z][a-zA-Z0-9-_.]{8,15}$', name):
                return JsonResponse({'MESSAGE' : 'INVALD_NAME'}, status=400)

            # 유저가 사용하고자 하는 비밀번호를 정규식으로 검증
            # 적어도 대문자 알파벳, 소문자 알파벳, 숫자, 일부 특수문자를 포함한 8~20자 사용가능
            if not re.match(
                '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*\-_=+?~`])[A-Za-z0-9!@#$%^&*\-_=+?~`]{8,20}$', password
            ):
                return JsonResponse({'MESSAGE' : 'INVALD_PASSWORD'}, status=400)

            # 유저가 사용하고자 하는 아이디가 이미 존재할 경우 에러 반환
            if User.objects.filter(name=name).exists():
                return JsonResponse({'MESSAGE' : 'NAME_EXISTS'}, status=409)

            # 유저가 입력한 비밀번호를 bcrypt를 활용해 암호화
            hashed_password = bcrypt.hashpw(
                password.encode('utf-8'), bcrypt.gensalt()
            ).decode('utf-8')

            # 유저가 입력한 아이디, 암호화 된 비밀번호, 닉네임을 DB에 입력
            # 초기 닉네임은 유저의 아이디와 동일
            User.objects.create(name = name, password = hashed_password, nickname = name)
            return JsonResponse({'MESSAGE' : 'SUCCESS'}, status=201)

        # 입력값(아이디 혹은 비밀번호) 중 하나라도 빈 칸으로 들어오면 에러 반환
        except KeyError:
            return JsonResponse({'MESSAGE' : 'KEY_ERROR'}, status=400)


class SignInView(View):
    def post(self, request):
        try:
            data     = json.loads(request.body)
            name     = data['name']
            password = data['password']
            user     = User.objects.get(name=name)

            # 로그인하게 위해 입력한 비밀번호를 bcrypt를 통해 암화화하며 해당 비밀번호가 암호화 되어 저장되어 있는 비밀번호와 불일치 시 에러 반환
            if not bcrypt.checkpw(password.encode('utf-8'), user.password.encode('utf-8')):
                return JsonResponse({'MESSAGE':'INVALID_USER'}, status=401)

            # 아이디와 비밀번호가 알맞게 입력된다면 DB 상 입력되어 있는 해당 유저의 ID를 jwt로 복호화 해 생성
            # 후에 프론트 사이드로 토큰과 status_code(200)를 반환해 로그인에 성공했음을 알림
            access_token = jwt.encode({'user_id':user.id}, SECRET_KEY, algorithm = ALGORITHM)
            return JsonResponse({'MESSAGE':'SUCCESS', 'ACCESS_TOKEN': access_token}, status=200)

        # 입력값(아이디 혹은 비밀번호) 중 하나라도 빈 칸으로 들어오면 에러 반환
        except KeyError:
            return JsonResponse({'MESSAGE':'KEY_ERROR'}, status=400)

        # 유저가 입력한 아이디가 존재하지 않을 경우 에러 반환
        except User.DoesNotExist:
            return JsonResponse({'MESSAGE':'USER_DOES_NOT_EXIST'}, status=404)
