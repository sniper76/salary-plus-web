import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/data/datasource/local/local_storage_datasource.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/datasource/remote/api_request_dio_factory.dart';
import 'package:act_cms/data/datasource/remote/api_request_header_handler.dart';
import 'package:act_cms/data/repository/admin_acceptor_repository_impl.dart';
import 'package:act_cms/data/repository/admin_app_repository_impl.dart';
import 'package:act_cms/data/repository/admin_auth_repository_impl.dart';
import 'package:act_cms/data/repository/admin_campaign_repository_impl.dart';
import 'package:act_cms/data/repository/admin_cms_commons_repository_impl.dart';
import 'package:act_cms/data/repository/admin_comment_repository_impl.dart';
import 'package:act_cms/data/repository/admin_digital_document_repository_impl.dart';
import 'package:act_cms/data/repository/admin_local_storage_repository_impl.dart';
import 'package:act_cms/data/repository/admin_popup_repository_impl.dart';
import 'package:act_cms/data/repository/admin_post_repository_impl.dart';
import 'package:act_cms/data/repository/admin_push_repository_impl.dart';
import 'package:act_cms/data/repository/admin_solidarity_repository_impl.dart';
import 'package:act_cms/data/repository/admin_statistics_repository_impl.dart';
import 'package:act_cms/data/repository/admin_stock_repository_impl.dart';
import 'package:act_cms/data/repository/admin_stop_word_repository_impl.dart';
import 'package:act_cms/data/repository/admin_user_repository_impl.dart';
import 'package:act_cms/domain/repository/admin_acceptor_repository.dart';
import 'package:act_cms/domain/repository/admin_app_repository.dart';
import 'package:act_cms/domain/repository/admin_auth_repository.dart';
import 'package:act_cms/domain/repository/admin_campaign_repository.dart';
import 'package:act_cms/domain/repository/admin_cms_commons_repository.dart';
import 'package:act_cms/domain/repository/admin_comment_repository.dart';
import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';
import 'package:act_cms/domain/repository/admin_popup_repository.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:act_cms/domain/repository/admin_push_repository.dart';
import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:act_cms/domain/repository/admin_statistics_repository.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:act_cms/domain/repository/admin_stop_word_repository.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:act_cms/domain/usecase/admin_acceptor/assign_accept_user.dart';
import 'package:act_cms/domain/usecase/admin_acceptor/fire_accept_user.dart';
import 'package:act_cms/domain/usecase/admin_acceptor/get_acceptance_list.dart';
import 'package:act_cms/domain/usecase/admin_auth/change_password.dart';
import 'package:act_cms/domain/usecase/admin_auth/login.dart';
import 'package:act_cms/domain/usecase/admin_campaign/campaign_download_csv.dart';
import 'package:act_cms/domain/usecase/admin_campaign/create_campaign.dart';
import 'package:act_cms/domain/usecase/admin_campaign/delete_campaign.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaign.dart';
import 'package:act_cms/domain/usecase/admin_campaign/get_campaigns.dart';
import 'package:act_cms/domain/usecase/admin_campaign/request_zipfile.dart';
import 'package:act_cms/domain/usecase/admin_campaign/update_campaign.dart';
import 'package:act_cms/domain/usecase/admin_cms/get_cms_commons.dart';
import 'package:act_cms/domain/usecase/admin_comment/create_comment.dart';
import 'package:act_cms/domain/usecase/admin_comment/create_comment_replies.dart';
import 'package:act_cms/domain/usecase/admin_comment/find_comments.dart';
import 'package:act_cms/domain/usecase/admin_comment/find_replies.dart';
import 'package:act_cms/domain/usecase/admin_comment/edit_comment.dart';
import 'package:act_cms/domain/usecase/admin_comment/update_comment_status.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/create_zip_file.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/delete_document.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/download_digital_document_csv.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_digital_document_users.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_document_preview.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/get_user_digital_document_pdf.dart';
import 'package:act_cms/domain/usecase/admin_digital_document/update_digital_document_reference_date.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/domain/usecase/admin_popup/create_popup.dart';
import 'package:act_cms/domain/usecase/admin_popup/delete_popup.dart';
import 'package:act_cms/domain/usecase/admin_popup/find_popup.dart';
import 'package:act_cms/domain/usecase/admin_popup/find_popups.dart';
import 'package:act_cms/domain/usecase/admin_popup/update_popup.dart';
import 'package:act_cms/domain/usecase/admin_post/create_post.dart';
import 'package:act_cms/domain/usecase/admin_post/duplicate_post.dart';
import 'package:act_cms/domain/usecase/admin_post/duplicate_stcok_group_post.dart';
import 'package:act_cms/domain/usecase/admin_post/find_posts.dart';
import 'package:act_cms/domain/usecase/admin_post/get_post.dart';
import 'package:act_cms/domain/usecase/admin_post/get_report_detail.dart';
import 'package:act_cms/domain/usecase/admin_post/get_reports.dart';
import 'package:act_cms/domain/usecase/admin_post/update_post.dart';
import 'package:act_cms/domain/usecase/admin_post/update_report_status.dart';
import 'package:act_cms/domain/usecase/admin_push/create_push.dart';
import 'package:act_cms/domain/usecase/admin_push/delete_push.dart';
import 'package:act_cms/domain/usecase/admin_push/find_individual_push.dart';
import 'package:act_cms/domain/usecase/admin_push/find_pushs.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/delete_solidarity_leader.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/withdraw_solidarity_leader_applicant.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/set_solidarity_active.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/set_solidarity_corporation_leader.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/set_solidarity_leader.dart';
import 'package:act_cms/domain/usecase/admin_solidarity/update_solidarity_leader_comment.dart';
import 'package:act_cms/domain/usecase/admin_statistics/get_age_statistics.dart';
import 'package:act_cms/domain/usecase/admin_statistics/get_gender_statistics.dart';
import 'package:act_cms/domain/usecase/admin_statistics/get_statistics.dart';
import 'package:act_cms/domain/usecase/admin_stock/add_dummy_stock.dart';
import 'package:act_cms/domain/usecase/admin_stock/create_reference_dates.dart';
import 'package:act_cms/domain/usecase/admin_stock/create_stock_group.dart';
import 'package:act_cms/domain/usecase/admin_stock/delete_dummy_stock.dart';
import 'package:act_cms/domain/usecase/admin_stock/delete_reference_date.dart';
import 'package:act_cms/domain/usecase/admin_stock/delete_stock_group.dart';
import 'package:act_cms/domain/usecase/admin_stock/download_stocks_csv.dart';
import 'package:act_cms/domain/usecase/admin_stock/fetch_user_me.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_auto_complete_groups.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_auto_complete_stocks.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_dummy_stocks.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_groups.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_reference_dates.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_solidarity_leader_election_application.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stock_detail.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stock_group_detail.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stock_statistics.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stocks.dart';
import 'package:act_cms/domain/usecase/admin_stock/update_reference_date.dart';
import 'package:act_cms/domain/usecase/admin_stock/update_stock_group_detail.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/change_stop_word_status.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/create_stop_word.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/delete_stop_word.dart';
import 'package:act_cms/domain/usecase/admin_stop_word/get_stop_words.dart';
import 'package:act_cms/domain/usecase/admin_users/add_role_to_user.dart';
import 'package:act_cms/domain/usecase/admin_users/assign_admin.dart';
import 'package:act_cms/domain/usecase/admin_users/create_corporation.dart';
import 'package:act_cms/domain/usecase/admin_users/delete_corporation.dart';
import 'package:act_cms/domain/usecase/admin_users/download_confidential.dart';
import 'package:act_cms/domain/usecase/admin_users/get_corporations.dart';
import 'package:act_cms/domain/usecase/admin_users/get_user_detail.dart';
import 'package:act_cms/domain/usecase/admin_users/get_user_stocks.dart';
import 'package:act_cms/domain/usecase/admin_users/get_users.dart';
import 'package:act_cms/domain/usecase/admin_users/revoke_admin_user.dart';
import 'package:act_cms/domain/usecase/admin_users/update_corporation.dart';
import 'package:act_cms/domain/usecase/admin_users/update_user_nickname.dart';
import 'package:act_cms/domain/usecase/admin_users/withdraw_service.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/delete_zip_file_data.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/get_zip_file_data.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/get_zip_file_data_list.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/polling_zip_file_list.dart';
import 'package:act_cms/domain/usecase/admin_zip_file_download/save_zip_file_data.dart';
import 'package:act_cms/domain/usecase/util/download_csv_util.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:get_it/get_it.dart';

import '../domain/usecase/admin_post/delete_post.dart';

final getIt = GetIt.instance;

class Injection {
  static initialize() async {
    getIt.registerSingleton<IEventBus>(EventBus());
    getIt.registerSingleton<UserAuthService>(UserAuthService()..init());
    getIt.registerSingleton<CMSCommonsService>(CMSCommonsService()..init());
    getIt.registerSingleton<ApiRequestHeaderHandler>(ApiRequestHeaderHandler());
    getIt.registerSingleton<ApiRequestDioFactory>(
        ApiRequestDioFactory(authService: getIt(), apiRequestHeaderHandler: getIt()));
    getIt.registerSingleton<ApiDataSource>(ApiDataSource(getIt()));
    getIt.registerSingleton<LocalStorageDataSource>(LocalStorageDataSource());
    getIt.registerSingleton<DownloadCsvUtil>(DownloadCsvUtil(apiRequestDioFactory: getIt()));

    getIt.registerSingleton<AdminAppRepository>(AdminAppRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminAuthRepository>(AdminAuthRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminCMSCommonsRepository>(AdminCMSCommonsRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminCommentRepository>(AdminCommentRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminDigitalDocumentRepository>(AdminDigitalDocumentRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminPostRepository>(AdminPostRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminPushRepository>(AdminPushRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminSolidarityRepository>(AdminSolidarityRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminStockRepository>(AdminStockRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminUserRepository>(AdminUserRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminStatisticsRepository>(AdminStatisticsRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminPopupRepository>(AdminPopupRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminCampaignRepository>(AdminCampaignRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminLocalStorageRepository>(AdminLocalStorageRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminAcceptorRepository>(AdminAcceptorRepositoryImpl(dataSource: getIt()));
    getIt.registerSingleton<AdminStopWordRepository>(AdminStopWordRepositoryImpl(dataSource: getIt()));

    getIt.registerSingleton<FetchUserMe>(FetchUserMe(authService: getIt(), repository: getIt()));
    // admin auth
    getIt.registerSingleton<ChangePassword>(ChangePassword(repository: getIt()));
    getIt.registerSingleton<Login>(Login(repository: getIt()));

    // admin cms
    getIt.registerSingleton<GetCMSCommons>(GetCMSCommons(cmsCommonsService: getIt(), repository: getIt()));

    // admin comment
    getIt.registerSingleton<FindReplies>(FindReplies(repository: getIt()));
    getIt.registerSingleton<FindComments>(FindComments(repository: getIt()));
    getIt.registerSingleton<UpdateCommentStatus>(UpdateCommentStatus(repository: getIt()));
    getIt.registerSingleton<CreateComment>(CreateComment(repository: getIt()));
    getIt.registerSingleton<EditComment>(EditComment(repository: getIt()));
    getIt.registerSingleton<CreateCommentReplies>(CreateCommentReplies(repository: getIt()));

    //admin digital document
    getIt.registerSingleton<CreateZipFile>(CreateZipFile(repository: getIt()));
    getIt.registerSingleton<DeleteDocument>(DeleteDocument(repository: getIt()));
    getIt.registerSingleton<DownloadDigitalDocumentCsv>(DownloadDigitalDocumentCsv(downloadCsvUtil: getIt()));

    //admin post
    getIt.registerSingleton<DuplicatePost>(DuplicatePost(repository: getIt()));
    getIt.registerSingleton<DuplicateStockGroupPost>(DuplicateStockGroupPost(repository: getIt()));
    getIt.registerSingleton<GetPost>(GetPost(repository: getIt()));
    getIt.registerSingleton<FindPosts>(FindPosts(repository: getIt()));
    getIt.registerSingleton<DeletePost>(DeletePost(repository: getIt()));
    getIt.registerSingleton<GetReportDetail>(GetReportDetail(repository: getIt()));
    getIt.registerSingleton<GetReports>(GetReports(repository: getIt()));
    getIt.registerSingleton<CreateAdminPost>(CreateAdminPost(repository: getIt()));
    getIt.registerSingleton<UpdatePost>(UpdatePost(repository: getIt()));

    //admin push
    getIt.registerSingleton<CreatePush>(CreatePush(repository: getIt()));
    getIt.registerSingleton<DeletePush>(DeletePush(repository: getIt()));
    getIt.registerSingleton<FindPushes>(FindPushes(repository: getIt()));
    getIt.registerSingleton<FindIndividualPush>(FindIndividualPush(repository: getIt()));

    getIt.registerSingleton<SetSolidarlityActive>(SetSolidarlityActive(repository: getIt()));
    getIt.registerSingleton<SetSolidarlityLeader>(SetSolidarlityLeader(repository: getIt()));
    getIt.registerSingleton<SetSolidarityCorporationLeader>(SetSolidarityCorporationLeader(repository: getIt()));
    getIt
        .registerSingleton<WithdrawSolidarlityLeaderApplicant>(WithdrawSolidarlityLeaderApplicant(repository: getIt()));
    getIt.registerSingleton<DeleteSolidarityLeader>(DeleteSolidarityLeader(repository: getIt()));

    //admin popup
    getIt.registerSingleton<FindPopups>(FindPopups(repository: getIt()));
    getIt.registerSingleton<FindPopup>(FindPopup(repository: getIt()));
    getIt.registerSingleton<CreatePopup>(CreatePopup(repository: getIt()));
    getIt.registerSingleton<UpdatePopup>(UpdatePopup(repository: getIt()));
    getIt.registerSingleton<DeletePopup>(DeletePopup(repository: getIt()));

    //admin stock
    getIt.registerSingleton<CreateReferenceDates>(CreateReferenceDates(repository: getIt()));
    getIt.registerSingleton<GetReferenceDates>(GetReferenceDates(repository: getIt()));
    getIt.registerSingleton<DownloadStocksCSV>(DownloadStocksCSV(downloadCsvUtil: getIt()));
    getIt.registerSingleton<GetAutoCompeteGroups>(GetAutoCompeteGroups(repository: getIt()));
    getIt.registerSingleton<GetAutoCompeteStocks>(GetAutoCompeteStocks(repository: getIt()));
    getIt.registerSingleton<GetGroups>(GetGroups(repository: getIt()));
    getIt.registerSingleton<GetStockDetail>(GetStockDetail(repository: getIt()));
    getIt.registerSingleton<GetStockGroupDetail>(GetStockGroupDetail(repository: getIt()));
    getIt.registerSingleton<GetStockStatistics>(GetStockStatistics(repository: getIt()));
    getIt.registerSingleton<GetStocks>(GetStocks(repository: getIt()));
    getIt.registerSingleton<UpdateReferenceDate>(UpdateReferenceDate(repository: getIt()));
    getIt
        .registerSingleton<UpdateDigitalDocumentReferenceDate>(UpdateDigitalDocumentReferenceDate(repository: getIt()));
    getIt.registerSingleton<UpdateStockGroupDetail>(UpdateStockGroupDetail(repository: getIt()));
    getIt.registerSingleton<UpdateSolidarityLeaderComment>(UpdateSolidarityLeaderComment(repository: getIt()));
    getIt.registerSingleton<AddDummyStock>(AddDummyStock(repository: getIt()));
    getIt.registerSingleton<DeleteDummyStock>(DeleteDummyStock(repository: getIt()));
    getIt.registerSingleton<DeleteStockGroup>(DeleteStockGroup(repository: getIt()));
    getIt.registerSingleton<GetSolidarityLeaderElectionApplcation>(
        GetSolidarityLeaderElectionApplcation(repository: getIt()));

    // admin user
    getIt.registerSingleton<GetUsers>(GetUsers(repository: getIt()));
    getIt.registerSingleton<GetCorporations>(GetCorporations(repository: getIt()));
    getIt.registerSingleton<GetUserDetail>(GetUserDetail(repository: getIt()));
    getIt.registerSingleton<UpdateUserNickName>(UpdateUserNickName(repository: getIt()));
    getIt.registerSingleton<AssignAdmin>(AssignAdmin(repository: getIt()));
    getIt.registerSingleton<AddRoleToUser>(AddRoleToUser(repository: getIt()));
    getIt.registerSingleton<WithdrawService>(WithdrawService(repository: getIt()));
    getIt.registerSingleton<GetUserStocks>(GetUserStocks(repository: getIt()));
    getIt.registerSingleton<CreateStockGroup>(CreateStockGroup(repository: getIt()));
    getIt.registerSingleton<UploadImage>(UploadImage(repository: getIt()));
    getIt.registerSingleton<UpdateReportStatus>(UpdateReportStatus(repository: getIt()));
    getIt.registerSingleton<GetDocumentPreview>(GetDocumentPreview(repository: getIt()));
    getIt.registerSingleton<CreateCorporation>(CreateCorporation(repository: getIt()));
    getIt.registerSingleton<DeleteCorporation>(DeleteCorporation(repository: getIt()));
    getIt.registerSingleton<UpdateCorporation>(UpdateCorporation(repository: getIt()));
    getIt.registerSingleton<GetUserDummyStocks>(GetUserDummyStocks(repository: getIt()));
    getIt.registerSingleton<DownloadConfidential>(DownloadConfidential(repository: getIt()));

    getIt.registerSingleton<GetStatistics>(GetStatistics(repository: getIt()));
    getIt.registerSingleton<GetGenderStatistics>(GetGenderStatistics(repository: getIt()));
    getIt.registerSingleton<GetAgeStatistics>(GetAgeStatistics(repository: getIt()));
    getIt.registerSingleton<RevokeAdminUser>(RevokeAdminUser(repository: getIt()));
    getIt.registerSingleton<DeleteReferenceDate>(DeleteReferenceDate(repository: getIt()));
    getIt.registerSingleton<GetDigitalDocumentUsers>(GetDigitalDocumentUsers(repository: getIt()));
    getIt.registerSingleton<GetUserDigitalDocumentPdf>(GetUserDigitalDocumentPdf(repository: getIt()));

    getIt.registerSingleton<GetCampaigns>(GetCampaigns(repository: getIt()));
    getIt.registerSingleton<GetCampaign>(GetCampaign(repository: getIt()));
    getIt.registerSingleton<CreateCampaign>(CreateCampaign(repository: getIt()));
    getIt.registerSingleton<DeleteCampaign>(DeleteCampaign(repository: getIt()));
    getIt.registerSingleton<CampaignDownloadCsv>(CampaignDownloadCsv(downloadCsvUtil: getIt()));
    getIt.registerSingleton<RequestZipFile>(RequestZipFile(repository: getIt()));
    getIt.registerSingleton<UpdateCampaign>(UpdateCampaign(repository: getIt()));

    getIt.registerSingleton<PollingZipFileList>(PollingZipFileList(repository: getIt()));
    getIt.registerSingleton<GetZipFileData>(GetZipFileData(repository: getIt()));
    getIt.registerSingleton<SaveZipFileData>(SaveZipFileData(repository: getIt()));
    getIt.registerSingleton<DeleteZipFileData>(DeleteZipFileData(repository: getIt()));
    getIt.registerSingleton<GetZipFileDataList>(GetZipFileDataList(repository: getIt()));

    //수임인
    getIt.registerSingleton<GetAcceptanceList>(GetAcceptanceList(repository: getIt()));
    getIt.registerSingleton<AssignAcceptUser>(AssignAcceptUser(repository: getIt()));
    getIt.registerSingleton<FireAcceptUser>(FireAcceptUser(repository: getIt()));

    // 금칙어
    getIt.registerSingleton<GetStopWords>(GetStopWords(repository: getIt()));
    getIt.registerSingleton<CreateStopWord>(CreateStopWord(repository: getIt()));
    getIt.registerSingleton<ChangeStopWordStatus>(ChangeStopWordStatus(repository: getIt()));
    getIt.registerSingleton<DeleteStopWord>(DeleteStopWord(repository: getIt()));
  }
}
