from django.db import models
from treasure_hunts.models import TreasureHunt

# Create your models here.
class Memory(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null=False, on_delete=models.CASCADE, related_name='memories_treasure_hunt')
    image = models.ImageField(upload_to='memories', blank=False, null=False)
    added_at = models.DateTimeField(auto_now_add = True)

    def _str_(self):
        return self.treasure_hunt.name + ' ' + self.added_at