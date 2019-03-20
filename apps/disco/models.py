# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
import uuid
# Create your models here.

class IIIFManifest(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid1)
    url = models.TextField()

    def __unicode__(self):
        return self.url

    class Meta:
        managed = True
        db_table = 'iiif_manifests'
