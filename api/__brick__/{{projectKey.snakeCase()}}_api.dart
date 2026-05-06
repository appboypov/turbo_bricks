import 'package:turbo_firestore_api/turbo_firestore_api.dart';
import 'package:turbo_serializable/abstracts/t_writeable.dart';

abstract class {{projectKey.pascalCase()}}Api<DTO extends TWriteable> extends TFirestoreApi<DTO> {
  {{projectKey.pascalCase()}}Api({
    required super.firebaseFirestore,
    required super.collectionPath,
    super.fromJson,
    super.toJson,
    super.tryAddLocalId,
    super.idFieldName,
    super.documentReferenceFieldName,
    super.isCollectionGroup,
    super.tryAddLocalDocumentReference,
  });
}
