import 'package:verify/app/shared/services/version_service.dart/models/version_model.dart';
import 'package:versionarte/versionarte.dart';

abstract class VersionService {
  Future<VersionModel?> call();
}

class VersionArteService implements VersionService {
  @override
  Future<VersionModel?> call() async {
    final result = await Versionarte.check(
      versionarteProvider: const RemoteConfigVersionarteProvider(
        initializeInternally: false,
      ),
    );
    switch (result.status) {
      case VersionarteStatus.upToDate:
      case VersionarteStatus.unknown:
        return null;
      case VersionarteStatus.shouldUpdate:
        return VersionModel(
          status: VersionStatus.optionalUpdate,
          title: result.details?.status.message?['title'],
          body: result.details?.status.message?['body'],
          news: result.details?.status.message?['news'],
        );
      case VersionarteStatus.mustUpdate:
        return VersionModel(
          status: VersionStatus.requiredUpdate,
          title: result.details?.status.message?['title'],
          body: result.details?.status.message?['body'],
          news: result.details?.status.message?['news'],
        );
      case VersionarteStatus.appInactive:
        return VersionModel(
          status: VersionStatus.inactive,
          title: result.details?.status.message?['title'],
          body: result.details?.status.message?['body'],
          news: result.details?.status.message?['news'],
        );
    }
  }
}
