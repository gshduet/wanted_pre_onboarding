from django.urls    import path
from products.views import ProductUpload, ProductSupport, ProductDetail, ProductList

urlpatterns = [
    path('', ProductList.as_view()),
    path('/upload', ProductUpload.as_view()),
    path('/<int:product_id>', ProductDetail.as_view()),
    path('/<int:product_id>/support', ProductSupport.as_view()),
]