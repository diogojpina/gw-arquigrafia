package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;

public class ComponentFile implements UploadedFile {
	private File file;

	public ComponentFile(File file) {
		if(!file.exists()){
			throw new RuntimeException("File not found.");
		}else if(!file.getName().toLowerCase().endsWith(".apk")){
			throw new RuntimeException("Supplied file is not an APK.");
		}else{
			this.file = file;
		}
	}

	@Override
	public String getContentType() {
		return "application/vnd.android.package-archive";
	}

	@Override
	public InputStream getFile() {
		try {
			return new FileInputStream(file);
		} catch (FileNotFoundException e) {
			throw new RuntimeException("File not found.");
		}
	}

	@Override
	public String getFileName() {
		return file.getName();
	}

}
