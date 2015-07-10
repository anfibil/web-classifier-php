<?php

namespace ODE\DatasetBundle\Models;

use Symfony\Component\HttpFoundation\File\UploadedFile;

/**
 * @Entity
 */
class Document
{
    /** @var UploadedFile  - not a persistent field! */
    private $file;
    
    /** @var string
     * @Column(type="string")
     */
    private $filePersistencePath;
    
    /** @var string */
    protected static $uploadDirectory = null;
    
    static public function setUploadDirectory($dir)
    {
        self::$uploadDirectory = $dir;
    }
    
    static public function getUploadDirectory()
    {
        if (self::$uploadDirectory === null) {
            throw new \RuntimeException("Failed attempt to access the file upload directory.");
        }
        return self::$uploadDirectory;
    }
    
    /**
     * Assumes 'type' => 'uploadedfile'
     */
    public function setFile(UploadedFile $file)
    {
        $this->file = $file;
    }
    public function getFile()
    {
        return new UploadedFile(self::getUploadDirectory() . DIRECTORY_SEPARATOR . $this->filePersistencePath, $this->file->getClientOriginalName());
    }
    
    public function getFilePersistencePath()
    {
        return $this->filePersistencePath;
    }
    
    public function processFile()
    {
        if (!($this->file instanceof UploadedFile)) {
            return 1;
        }

        if (file_exists($this->file->getClientOriginalName()) &&
            md5_file($this->file->getPath() . DIRECTORY_SEPARATOR . $this->file->getBasename()) == md5_file($this->file->getClientOriginalName())) {
            return 2;
        } elseif (file_exists(self::getUploadDirectory() . DIRECTORY_SEPARATOR . $this->file->getClientOriginalName())) {
            return 2;
        }

        $uploadFileMover = new UploadFileMover();
        $this->filePersistencePath = $uploadFileMover->moveUploadedFile($this->file, self::getUploadDirectory());
        return 0;
    }
}