from arches.app.datatypes.datatypes import FileListDataType
from arches.app.models import models
from arches.app.models.system_settings import settings

charting_widget = models.Widget.objects.get(name='charting-widget')

details = {
    'datatype': 'charting',
    'iconclass': 'fa fa-line-chart',
    'modulename': 'charting.py',
    'classname': 'ChartingDataType',
    'defaultwidget': charting_widget,
    'defaultconfig': None,
    'configcomponent': None,
    'configname': None,
    'isgeometric': False
    }

class ChartingDataType(FileListDataType):
    def __init__(self, model=None):
        super(ChartingDataType, self).__init__(model=model)

    def handle_request(self, current_tile, request, node):
        try:
            previously_saved_tile = models.TileModel.objects.filter(pk=current_tile.tileid)
            if previously_saved_tile.count() == 1:
                for previously_saved_file in previously_saved_tile[0].data[str(node.pk)]['files']:
                    previously_saved_file_has_been_removed = True
                    for incoming_file in current_tile.data[str(node.pk)]['files']:
                        if previously_saved_file['file_id'] == incoming_file['file_id']:
                            previously_saved_file_has_been_removed = False
                    if previously_saved_file_has_been_removed:
                        deleted_file = models.File.objects.get(pk=previously_saved_file["file_id"])
                        deleted_file.delete()

            files = request.FILES.getlist('file-list_' + str(node.pk), [])
            for file_data in files:
                file_model = models.File()
                file_model.path = file_data
                file_model.save()
                for file_json in current_tile.data[str(node.pk)]['files']:
                    if file_json["name"] == file_data.name and file_json["url"] is None:
                        file_json["file_id"] = str(file_model.pk)
                        file_json["url"] = str(file_model.path.url)
                        file_json["status"] = 'uploaded'
        except Exception as e:
            print e
