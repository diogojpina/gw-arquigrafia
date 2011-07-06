/*
*    UNIVERSIDADE DE SÃO PAULO.
*    Author: Marco Aurélio Gerosa (gerosa@ime.usp.br)
*    This project was/is sponsored by RNP and FAPESP.
*
*    This file is part of Groupware Workbench (http://www.groupwareworkbench.org.br).
*
*    Groupware Workbench is free software: you can redistribute it and/or modify
*    it under the terms of the GNU Lesser General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    Groupware Workbench is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU Lesser General Public License for more details.
*
*    You should have received a copy of the GNU Lesser General Public License
*    along with Swift.  If not, see <http://www.gnu.org/licenses/>.
*/
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
