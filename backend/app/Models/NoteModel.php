<?php

namespace App\Models;

use CodeIgniter\Model;

class NoteModel extends Model
{
    protected $table            = 'notes';
    protected $primaryKey       = 'id';
    protected $allowedFields    = ['title', 'description', 'category', 'image_path', 'audio_path'];
    protected $useTimestamps    = true;
    protected $createdField     = 'created_at';
    protected $updatedField     = 'updated_at';
    protected $useSoftDeletes   = true; // Aktifkan soft delete
    protected $deletedField     = 'deleted_at'; // Nama kolom untuk soft delete

    // Mendapatkan semua catatan, dengan opsi kategori
    public function getNotes($category = null)
    {
        $builder = $this->builder();
        
        // Jika kategori diberikan, filter berdasarkan kategori
        if ($category) {
            $builder->where('category', $category);
        }

        // Hanya ambil catatan yang belum dihapus (deleted_at null)
        $builder->where('deleted_at', null);

        return $builder->get()->getResultArray();  // Mengambil hasil sebagai array
    }

    // Mendapatkan catatan berdasarkan ID
    public function getNote($id)
    {
        error_log("Querying note with ID: " . $id);
        return $this->find($id); // Menggunakan find() untuk mendapatkan catatan berdasarkan ID
    }

    // Menambahkan catatan baru
    public function addNote($data)
    {
        // Validasi data untuk memastikan 'title' dan 'description' ada
        if (empty($data['title']) || empty($data['description'])) {
            return false;
        }

        // Set 'image_path' dan 'audio_path' ke null jika tidak ada
        $data['image_path'] = $data['image_path'] ?? null;
        $data['audio_path'] = $data['audio_path'] ?? null;

        // Insert data ke dalam tabel
        return $this->insert($data);
    }

    // Memperbarui catatan berdasarkan ID
    public function updateNote($id, $data)
    {
        // Periksa apakah catatan dengan ID ada
        $note = $this->find($id);
    
        if ($note) {
            // Tambahkan logging untuk debug
            log_message('info', 'Data yang akan diperbarui: ' . json_encode($data));
    
            // Lakukan update
            $result = $this->update($id, $data);
    
            if ($result) {
                log_message('info', "Update berhasil untuk ID: {$id}");
                return true;
            } else {
                log_message('error', "Update gagal untuk ID: {$id}");
            }
        } else {
            log_message('error', "Catatan dengan ID: {$id} tidak ditemukan.");
        }
        return false;
    }

    // Menghapus catatan berdasarkan ID (Soft Delete)
    public function softDeleteNote($id)
    {
        return $this->update($id, ['deleted_at' => date('Y-m-d H:i:s')]);
    }
}
