import 'package:act_cms/domain/model/enum/digital_document_answer_type.dart';

String? dateToJson(DateTime? date) => date?.toUtc().toIso8601String();

String? digitalDocumentAnswerTypeToJson(DigitalDocumentAnswerType? type) => type?.value;
