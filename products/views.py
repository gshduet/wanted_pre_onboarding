import json
from datetime import datetime

from django.http      import JsonResponse
from django.views     import View
from django.db.models import Q

from products.models import Product, Detail
from core.utils      import login_decorator


# 상품 등록 API
class ProductUpload(View):

    @login_decorator
    def post(self,request):
        try:
            data = json.loads(request.body)
            user                = request.user
            title               = data['title']
            context             = data['context']
            target_amount       = data['target_amount']
            support_per_session = data['support_per_session']
            end_date            = data['end_date']

            new_product = Product.objects.create(
                user                = user,
                title               = title,
                context             = context,
                target_amount       = target_amount,
                support_per_session = support_per_session,
                end_date            = end_date
            )

            Detail.objects.create(
                product         = new_product,
                supporter_count = 0,
                current_amount  = 0,
                achievment_rate = 0
            )

            return JsonResponse({'MESSAGE' : 'SUCCESS'}, status=201)
        
        except KeyError:
            return JsonResponse({'MESSAGE' : 'KEY_ERROR'}, status = 400)


# 상품 상세정보 조회, 수정 및 삭제 API
class ProductDetail(View):

    def get(self,request,product_id):
        try:
            product = Product.objects.select_related('detail').get(id=product_id)

            if product.is_delete:
                return JsonResponse({'MESSAGE' : 'PRODUCT_DOES_NOT_EXIST'}, status = 404)

            data = {
                'user'            : product.user.name,
                'title'           : product.title,
                'contenxt'        : product.context,
                'target_amount'   : product.target_amount,
                'supporter_count' : product.detail.supporter_count,
                'current_amount'  : product.detail.current_amount,
                'achievment_rate' : product.detail.achievment_rate,
                'end_date'        : (product.end_date - datetime.now().date()).days
            }

            return JsonResponse({'MESSAGE' : 'SUCCESS', 'DATA' : data}, status = 200)

        except Product.DoesNotExist:
            return JsonResponse({'MESSAGE' : 'PRODUCT_DOES_NOT_EXIST'}, status = 404)

    @login_decorator
    def patch(self,request,product_id):
        try:
            data                = json.loads(request.body)
            product             = Product.objects.get(id=product_id)
            user                = request.user
            title               = data['title']
            context             = data['context']
            support_per_session = data['support_per_session']
            end_date            = data['end_date']

            if not product.user == user:
                return JsonResponse({'MESSAGE' : 'INVALID_USER'}, status=403)
            
            product.title               = title
            product.context             = context
            product.support_per_session = support_per_session
            product.end_date            = end_date
            product.save()

            return JsonResponse({'MESSAGE' : 'SUCCESS'}, status=200)

        except KeyError:
            return JsonResponse({'MESSAGE' : 'KEY_ERROR'}, status = 400)

        except Product.DoesNotExist:
            return JsonResponse({'MESSAGE' : 'PRODUCT_DOES_NOT_EXIST'}, status = 404)

    # 상품의 삭제를 soft_delete 방식으로 구현하여 이력 관리
    @login_decorator
    def delete(self,request,product_id):
        try:
            product = Product.objects.prefetch_related('supporter_set').get(id=product_id)
            user    = request.user

            if not product.user == user:
                return JsonResponse({'MESSAGE' : 'INVALID_USER'}, status=403)

            product.delete_at = datetime.now()
            product.is_delete = True
            product.save()

            for supporter in product.supporter_set.all():
                supporter.delete_at = datetime.now()
                supporter.is_delete = True
                supporter.save()

            return JsonResponse({'MESSAGE' : 'SUCCESS'}, status=204)
        
        except Product.DoesNotExist:
            return JsonResponse({'MESSAGE' : 'PRODUCT_DOES_NOT_EXIST'}, status = 404)


# 상품 후원 및 후원 취소 API
class ProductSupport(View):

    @login_decorator
    def post(self,request,product_id):
        try:
            product = Product.objects.get(id=product_id)
            detail  = product.detail
            user    = request.user

            product.supporter_set.create(user = user, product = product)
            detail.supporter_count += 1
            detail.current_amount  += product.support_per_session
            detail.achievment_rate = str(
                (product.support_per_session 
                * detail.supporter_count)
                / product.target_amount
                * 100
            )
            detail.save()

            return JsonResponse({'MESSAGE' : 'SUCCESS'}, status=201)

        except KeyError:
            return JsonResponse({'MESSAGE' : 'KEY_ERROR'}, status = 400)

        except Product.DoesNotExist:
            return JsonResponse({'MESSAGE' : 'PRODUCT_DOES_NOT_EXIST'}, status = 404)

    # 후원 취소 역시 soft_delete 방식으로 구현, 후원 및 후원 취소 이력 관리
    @login_decorator
    def delete(self,request,product_id):
        try:
            product       = Product.objects.get(id=product_id)
            detail        = product.detail
            user          = request.user
            last_surpport = product.supporter_set\
                                   .filter(user_id = user.id, is_delete = 0)\
                                   .last()

            last_surpport.delete_at = datetime.now()
            last_surpport.is_delete = True
            last_surpport.save()

            detail.supporter_count -= 1
            detail.current_amount  -= product.support_per_session
            detail.achievment_rate = str(
                (product.support_per_session 
                * detail.supporter_count)
                / product.target_amount
                * 100
            )
            detail.save()

            return JsonResponse({'MESSAGE' : 'SUCCESS'}, status=204)

        except Product.DoesNotExist:
            return JsonResponse({'MESSAGE' : 'PRODUCT_DOES_NOT_EXIST'}, status = 404)


# 상품 리스트 조회 API
class ProductList(View):

    def get(self,request):
        offset   = int(request.GET.get('offset', 0))
        limit    = int(request.GET.get('limit', 15))
        search   = request.GET.get('search', None)
        ordering = request.GET.get('order_by', 'id')

        q = Q()

        order_by_set = {
            'id'             : 'id',
            'recent'         : 'create_at',
            'old'            : '-create_at',
            'highest_amount' : 'detail__current_amount',
            'lowest_amount'  : '-detail__current_amount',
        }

        if search:
            q = Q(title__icontains=search)

        products = Product.objects.select_related('detail','user')\
                                  .filter(q)\
                                  .order_by(order_by_set[ordering])[offset:offset+limit]

        data = [{
            'product_ud'              : product.id,
            'product_title'           : product.title,
            'product_owner'           : product.user.nickname,
            'product_current_amount'  : f'{int(product.detail.current_amount)} 원',
            'product_achievment_rate' : f'{product.detail.achievment_rate} %',
            'product_dead_line'       : (product.end_date - datetime.now().date()).days
        }for product in products]

        return JsonResponse({'MESSAGE' : 'SUCCESS', 'DATA' : data}, status = 200)