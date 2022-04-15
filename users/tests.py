import json
import jwt
import bcrypt

from config.settings import SECRET_KEY, ALGORITHM
from django.test     import TransactionTestCase, Client

from users.models    import User


class SignUpTest(TransactionTestCase):
    def setUp(self):
        User.objects.create(
            id       = 1,
            name     = 'test_name_01',
            password = '1Q2W3e4r!',
            nickname = 'test_name_01'
        )
    
    def tearDown(self):
        User.objects.all().delete()

    # 회원가입 성공
    def test_SignUp_success(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_02',
            'password' : '1Q2W3e4r!'
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(),{'MESSAGE' : 'SUCCESS'})
        self.assertEqual(response.status_code, 201)

    # 회원가입 실패 : 회원 아이디 중복
    def test_SignUp_Failure_UserExist(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_01',
            'password' : '1Q2W3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'NAME_EXISTS'})
        self.assertEqual(response.status_code, 409)

    # 회원가입 실패 : 회원가입 시 비밀번호 미입력
    def test_SignUp_Failure_KeyError(self):
        client = Client()

        new_user = {
            'password' : '1Q2W3e4r!'
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'KEY_ERROR'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 회원가입 시 아이디 미입력
    def test_SignUp_Failure_KeyError(self):
        client = Client()

        new_user = {
            'name' : 'test_name_03',
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'KEY_ERROR'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 아이디 생성조건 불충족 (알파벳으로 시작)
    def test_SignUp_Failure_Valid_Name_01(self):
        client = Client()

        new_user = {
            'name'     : '04_test_name',
            'password' : '1Q2W3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_NAME'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 아이디 생성조건 불충족 (아이디 최소길이(8글자) 미달)
    def test_SignUp_Failure_Valid_Name_02(self):
        client = Client()

        new_user = {
            'name'     : 'test_04',
            'password' : '1Q2W3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_NAME'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 아이디 생성조건 불충족 (아이디 최대길이(15글자) 초과)
    def test_SignUp_Failure_Valid_Name_03(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04_fail',
            'password' : '1Q2W3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_NAME'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 아이디 생성조건 불충족 (허용 된 '-', '_', '.' 이외의 특수문자 사용)
    def test_SignUp_Failure_Valid_Name_04(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04@',
            'password' : '1Q2W3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_NAME'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 비밀번호 생성조건 불충족 (적어도 하나 이상의 대문자 알파벳을 포함)
    def test_SignUp_Failure_Valid_Password_01(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04',
            'password' : '1q2w3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_PASSWORD'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 비밀번호 생성조건 불충족 (적어도 하나 이상의 소문자 알파벳을 포함)
    def test_SignUp_Failure_Valid_Password_02(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04',
            'password' : '1Q2W3E4R!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_PASSWORD'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 비밀번호 생성조건 불충족 (적어도 하나 이상의 숫자를 포함)
    def test_SignUp_Failure_Valid_Password_03(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04',
            'password' : 'QWERqwer!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_PASSWORD'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 비밀번호 생성조건 불충족 (적어도 하나 이상의 특수문자 포함)
    def test_SignUp_Failure_Valid_Password_04(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04',
            'password' : '1Q2W3e4r1Q2W3e4r' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_PASSWORD'})
        self.assertEqual(response.status_code, 400)

    # 회원가입 실패 : 비밀번호 생성조건 불충족 (비밀번호 최소길이(8글자) 미달)
    def test_SignUp_Failure_Valid_Password_05(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04',
            'password' : '1Q2W3e!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_PASSWORD'})
        self.assertEqual(response.status_code, 400)
    
    # 회원가입 실패 : 비밀번호 생성조건 불충족 (비밀번호 최대길이(21글자) 초과)
    def test_SignUp_Failure_Valid_Password_06(self):
        client = Client()

        new_user = {
            'name'     : 'test_name_04',
            'password' : '1Q2W3e4r!1Q2W3e4r!1Q2W3e4r!' 
        }

        response = client.post(
            '/users/signup', json.dumps(new_user), content_type = 'application/json'
        )

        self.assertEqual(response.json(), {'MESSAGE' : 'INVALD_PASSWORD'})
        self.assertEqual(response.status_code, 400)


class SignInTest(TransactionTestCase):
    def setUp(self):
        User.objects.create(
            id       = 1,
            name     = 'test_name_01',
            password = bcrypt.hashpw(
                '1Q2W3e4r!'.encode('utf-8'), bcrypt.gensalt()
            ).decode('utf-8'),
        )

    def tearDown(self):
        User.objects.all().delete()

    # 로그인 성공
    def test_SignIn_Success(self):
        client = Client()

        user    = {
            'name'     : 'test_name_01',
            'password' : '1Q2W3e4r!'
        }

        response = client.post(
            '/users/signin', json.dumps(user), content_type = 'application/json'
        )
        access_token = jwt.encode({'user_id':1}, SECRET_KEY, algorithm = ALGORITHM)

        self.assertEqual(
            response.json(),
            {
                'MESSAGE':'SUCCESS', 'ACCESS_TOKEN': access_token
            }
        )
        self.assertEqual(response.status_code, 200)

    # 로그인 실패 : 존재하지 않는 유저
    def test_SignIn_Failure_User_DoesNotExist(self):
        client = Client()

        user    = {
            'name'     : 'test_name_02',
            'password' : '1Q2W3e4r!'
        }

        response = client.post(
            '/users/signin', json.dumps(user), content_type = 'application/json'
        )
        access_token = jwt.encode({'user_id':1}, SECRET_KEY, algorithm = ALGORITHM)

        self.assertEqual(
            response.json(),{'MESSAGE':'USER_DOES_NOT_EXIST'}
        )
        self.assertEqual(response.status_code, 404)

    # 로그인 실패 : 로그인 시 아이디 미입력
    def test_SignIn_Failure_KeyError_01(self):
        client = Client()

        user    = {
            'password' : '1Q2W3e4r!'
        }

        response = client.post(
            '/users/signin', json.dumps(user), content_type = 'application/json'
        )
        access_token = jwt.encode({'user_id':1}, SECRET_KEY, algorithm = ALGORITHM)

        self.assertEqual(
            response.json(),{'MESSAGE':'KEY_ERROR'}
        )
        self.assertEqual(response.status_code, 400)

    # 로그인 실패 : 로그인 시 비밀번호 미입력
    def test_SignIn_Failure_KeyError_02(self):
        client = Client()

        user    = {
            'name'     : 'test_name_01'
        }

        response = client.post(
            '/users/signin', json.dumps(user), content_type = 'application/json'
        )
        access_token = jwt.encode({'user_id':1}, SECRET_KEY, algorithm = ALGORITHM)

        self.assertEqual(
            response.json(),{'MESSAGE':'KEY_ERROR'}
        )
        self.assertEqual(response.status_code, 400)

    # 로그인 실패 : 틀린 아이디
    def test_SignIn_Failure_INVALID_USER_01(self):
        client = Client()

        user    = {
            'name'     : 'test_name_02',
            'password' : '1Q2W3e4r!'
        }

        response = client.post(
            '/users/signin', json.dumps(user), content_type = 'application/json'
        )
        access_token = jwt.encode({'user_id':1}, SECRET_KEY, algorithm = ALGORITHM)

        self.assertEqual(
            response.json(),{'MESSAGE':'INVALID_USER'}
        )
        self.assertEqual(response.status_code, 401)

    # 로그인 실패 : 틀린 비밀번호
    def test_SignIn_Failure_INVALID_USER_01(self):
        client = Client()

        user    = {
            'name'     : 'test_name_01',
            'password' : '1Q2W3e4r@'
        }

        response = client.post(
            '/users/signin', json.dumps(user), content_type = 'application/json'
        )
        access_token = jwt.encode({'user_id':1}, SECRET_KEY, algorithm = ALGORITHM)

        self.assertEqual(
            response.json(),{'MESSAGE':'INVALID_USER'}
        )
        self.assertEqual(response.status_code, 401)