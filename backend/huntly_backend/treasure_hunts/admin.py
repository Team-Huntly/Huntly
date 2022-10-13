from django.contrib import admin
from treasure_hunts.models import *
# Register your models here.

admin.site.register(TreasureHunt)
admin.site.register(Clue)
admin.site.register(Theme)
admin.site.register(Team)
admin.site.register(TeamProgress)
admin.site.register(Preset)