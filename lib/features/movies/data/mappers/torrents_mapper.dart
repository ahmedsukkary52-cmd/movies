import 'package:moives/features/movies/data/models/response/movie_list/torrents_dto.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/torrents.dart';

extension TorrentsMapper on TorrentsDto {
  Torrents toTorrents() {
    return Torrents(
      url: url,
      dateUploadedUnix: dateUploadedUnix,
      dateUploaded: dateUploaded,
      audioChannels: audioChannels,
      bitDepth: bitDepth,
      hash: hash,
      isRepack: isRepack,
      peers: peers,
      quality: quality,
      seeds: seeds,
      size: size,
      sizeBytes: sizeBytes,
      type: type,
      videoCodec: videoCodec,
    );
  }
}
