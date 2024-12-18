<?php

namespace App\Controllers;

use App\Models\NoteModel;
use CodeIgniter\RESTful\ResourceController;

class NoteController extends ResourceController
{
    protected $modelName = 'App\Models\NoteModel';
    protected $format    = 'json';

    // GET: Fetch all notes
    public function index()
    {
        $category = $this->request->getGet('category');
        $notes = $this->model->getNotes($category); // Pastikan metode getNotes ada di model
        return $this->respond($notes, 200);
    }

    // GET: Fetch a single note by ID
    public function show($id = null)
    {
        error_log("Received ID: " . $id);
        $note = $this->model->getNote($id); // Pastikan metode getNote ada di model
        if ($note) {
            return $this->respond($note, 200);
        }
        return $this->failNotFound('Note not found');
    }

    // POST: Create a new note
    public function create()
    {
        $data = $this->request->getJSON(true);

        // Cek jika ada file gambar atau audio
        $imagePath = $this->handleFileUpload('image'); // Handle file gambar
        $audioPath = $this->handleFileUpload('audio'); // Handle file audio

        // Jika file gambar atau audio berhasil di-upload, masukkan path-nya ke data
        if ($imagePath) {
            $data['image_path'] = $imagePath;
        }

        if ($audioPath) {
            $data['audio_path'] = $audioPath;
        }

        // Validasi data input
        $validation = \Config\Services::validation();
        if (!$validation->run($data, 'note')) {
            return $this->failValidationErrors($validation->getErrors());
        }

        if (!$this->model->addNote($data)) {
            return $this->fail('Failed to create note');
        }

        return $this->respondCreated(['message' => 'Note created successfully']);
    }

    // Fungsi untuk menangani upload file
    private function handleFileUpload($type)
    {
        $file = $this->request->getFile($type);
        
        if ($file && $file->isValid() && !$file->hasMoved()) {
            $newName = $file->getRandomName(); // Nama file acak
            $file->move(WRITEPATH . 'uploads', $newName); // Tentukan folder penyimpanan file
            return 'uploads/' . $newName; // Path relatif yang disimpan dalam database
        }

        return null; // Jika tidak ada file atau terjadi kesalahan
    }

    public function update($id = null)
    {
        $data = $this->request->getRawInput(); // Ambil input data
    
        $validation = \Config\Services::validation();
    
        // Validasi data input
        if (!$validation->run($data, 'note')) {
            return $this->failValidationErrors($validation->getErrors()); // Jika gagal validasi
        }
    
        // Cek apakah note ada
        $note = $this->model->getNote($id);
        if (!$note) {
            return $this->failNotFound('Note not found');
        }
    
        // Lakukan update
        if ($this->model->update($id, $data)) {
            return $this->respond(['message' => 'Note updated successfully'], 200);
        }
    
        return $this->fail('Failed to update note');
    }

    // DELETE: Soft delete a note
    public function delete($id = null)
    {
        // Periksa apakah catatan ada
        $note = $this->model->find($id);
        if (!$note) {
            return $this->failNotFound("Catatan dengan ID $id tidak ditemukan");
        }

        // Hapus catatan (soft delete)
        if ($this->model->delete($id)) {
            return $this->respondDeleted(['message' => "Catatan dengan ID $id berhasil dihapus"]);
        }

        return $this->fail("Gagal menghapus catatan dengan ID $id");
    }
}