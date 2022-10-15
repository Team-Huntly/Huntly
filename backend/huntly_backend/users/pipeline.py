import requests
from django.core.files.base import ContentFile

def get_avatar(backend, strategy, details, response,
        user=None, *args, **kwargs):
    url = None
    if backend.name == 'facebook':
        url = "http://graph.facebook.com/%s/picture?type=large"%response['id']
    if backend.name == 'twitter':
        url = response.get('profile_image_url', '').replace('_normal','')
    if backend.name == 'google-oauth2':
        print(response, "aaaaaaaaaaaaaaaaaaaaaaaaaaa")
        url = response.get('picture')
    if url:
        user.profile_pic.save('avatar_%s.png'%(user.id), ContentFile(requests.get(url).content))