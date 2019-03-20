from arches.app.datatypes.base import BaseDataType
from arches.app.models import models
from arches.app.models.system_settings import settings

iiif_widget = models.Widget.objects.get(name='iiif-widget')

details = {
    'datatype': 'iiif-drawing',
    'iconclass': 'fa fa-file-code-o',
    'modulename': 'iiif.py',
    'classname': 'IIIFDrawingDataType',
    'defaultwidget': iiif_widget,
    'defaultconfig': {
        "rdmCollection": None
    },
    'configcomponent': 'views/components/datatypes/concept',
    'configname': 'concept-datatype-config',
    'isgeometric': False
    }


class IIIFDrawingDataType(BaseDataType):
    def get_strings(self, nodevalue):
        string_list = [nodevalue['manifestLabel']]
        for feature in nodevalue['features']:
            if feature['properties']['name'] != '':
                string_list.append(feature['properties']['name'])
        return string_list

    def append_to_document(self, document, nodevalue, nodeid, tile, provisional=False):
        string_list = self.get_strings(nodevalue)
        for string_item in string_list:
            document['strings'].append({'string': string_item, 'nodegroup_id': tile.nodegroup_id})
        for feature in nodevalue['features']:
            if feature['properties']['type'] is not None:
                valueid = feature['properties']['type']
                value = models.Value.objects.get(pk=valueid)
                document['domains'].append({'label': value.value, 'conceptid': value.concept_id, 'valueid': valueid, 'nodegroup_id': tile.nodegroup_id, 'provisional': provisional})

    def get_search_terms(self, nodevalue, nodeid=None):
        terms = []
        string_list = self.get_strings(nodevalue)
        for string_item in string_list:
            if string_item is not None:
                if settings.WORDS_PER_SEARCH_TERM == None or (len(string_item.split(' ')) < settings.WORDS_PER_SEARCH_TERM):
                    terms.append(string_item)
        return terms
