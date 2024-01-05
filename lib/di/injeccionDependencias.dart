
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:transcripcion_texto/ui/providers/transcripcion.dart';
import 'package:provider/single_child_widget.dart';

final getIt = GetIt.I;

void inicialzarInjeccionDependencias(){
  _vistas();
}

void _vistas() async{
  getIt.registerFactory(() => TranscripcionProvider());
}

List<SingleChildWidget> getProviders(){
  return [
    ChangeNotifierProvider(create: (_) => getIt<TranscripcionProvider>())
  ];
}