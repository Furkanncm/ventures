import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/share/share_repository.dart';

class AudioHistoryView extends ConsumerStatefulWidget {
  const AudioHistoryView({super.key});

  @override
  ConsumerState<AudioHistoryView> createState() => _AudioHistoryViewState();
}

class _AudioHistoryViewState extends ConsumerState<AudioHistoryView> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _playingRecordId;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlay(AudioRecord record) async {
    if (_playingRecordId == record.id) {
      await _audioPlayer.stop();
      setState(() => _playingRecordId = null);
    } else {
      await _audioPlayer.stop();

      await _audioPlayer.play(DeviceFileSource(record.filePath));

      setState(() => _playingRecordId = record.id);

      _audioPlayer.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() => _playingRecordId = null);
        }
      });
    }
  }

  /// Paylaşım Mantığı
  Future<void> _shareRecord(AudioRecord record) async {
    // Repository'i çağırıyoruz
    await ShareRepository.instance.shareAudio(record.filePath);
  }

  Future<void> _deleteRecord(AudioRecord record) async {
    final repository = ref.read(historyRepositoryProvider);

    await repository.deleteRecord(record);

    final _ = ref.refresh(historyListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ses Geçmişi'),
      ),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (err, stack) => Center(child: Text('Hata: $err')),

        data: (historyList) {
          if (historyList.isEmpty) {
            return const _EmptyHistoryView();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: historyList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final record = historyList[index];
              final isPlaying = _playingRecordId == record.id;
              return _HistoryItemCard(
                record: record,
                isPlaying: isPlaying,
                onPlayTap: () => _togglePlay(record),
                onDeleteTap: () => _deleteRecord(record),
                onShareTap: () => _shareRecord(record),
              );
            },
          );
        },
      ),
    );
  }
}

class _HistoryItemCard extends StatelessWidget {
  const _HistoryItemCard({
    required this.record,
    required this.isPlaying,
    required this.onPlayTap,
    required this.onDeleteTap,
    required this.onShareTap,
  });

  final AudioRecord record;
  final bool isPlaying;
  final VoidCallback onPlayTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        leading: CircleAvatar(
          backgroundColor: isPlaying ? Colors.amber : Colors.blueAccent,
          child: IconButton(
            icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
            color: Colors.white,
            onPressed: onPlayTap,
          ),
        ),

        title: Text(
          record.text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            DateFormat('dd MMM yyyy - HH:mm').format(record.createdAt),
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),

        // Sağ Taraf: Sil Butonu
        trailing: Row(
          mainAxisSize: MainAxisSize
              .min, // Row'un sadece butonlar kadar yer kaplaması için
          children: [
            // PAYLAŞ BUTONU
            IconButton(
              icon: const Icon(Icons.share, color: Colors.blueGrey),
              onPressed: onShareTap,
            ),
            // SİL BUTONU
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_edu, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Henüz kaydedilmiş bir ses yok.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
