-- Tabla de locales
CREATE TABLE locales (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE
);

-- Tabla de instituciones educativas, vinculada a un local
CREATE TABLE instituciones_educativas (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  local_id INT REFERENCES locales(id) ON DELETE CASCADE
);

-- Tabla de mesas (pueden ser generales o vinculadas a un local/institución si quieres)
CREATE TABLE mesas (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  local_id INT REFERENCES locales(id) ON DELETE CASCADE
);

-- Tabla de alumnos, vinculada a la institución educativa
CREATE TABLE alumnos (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  apellido TEXT NOT NULL,
  institucion_id INT REFERENCES instituciones_educativas(id) ON DELETE CASCADE
);

-- Tabla de acompañantes vinculados a alumnos
CREATE TABLE acompanantes (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  apellido TEXT NOT NULL,
  alumno_id INT REFERENCES alumnos(id) ON DELETE CASCADE
);

-- Tabla de registros del comité para guardar selecciones y datos ingresados
CREATE TABLE registros_comite (
  id SERIAL PRIMARY KEY,
  local_id INT REFERENCES locales(id),
  institucion_id INT REFERENCES instituciones_educativas(id),
  numero_alumnos INT NOT NULL,
  creado_en TIMESTAMP DEFAULT NOW()
);

-- Tabla para mapear alumnos + acompañantes a un registro comité (opcional para imprimir listas)
CREATE TABLE registro_alumnos (
  id SERIAL PRIMARY KEY,
  registro_comite_id INT REFERENCES registros_comite(id) ON DELETE CASCADE,
  alumno_id INT REFERENCES alumnos(id) ON DELETE CASCADE
);

-- Opcional: agregar políticas de Row Level Security (RLS) para control de acceso en Supabase
ALTER TABLE locales ENABLE ROW LEVEL SECURITY;
ALTER TABLE instituciones_educativas ENABLE ROW LEVEL SECURITY;
ALTER TABLE mesas ENABLE ROW LEVEL SECURITY;
ALTER TABLE alumnos ENABLE ROW LEVEL SECURITY;
ALTER TABLE acompanantes ENABLE ROW LEVEL SECURITY;
ALTER TABLE registros_comite ENABLE ROW LEVEL SECURITY;
ALTER TABLE registro_alumnos ENABLE ROW LEVEL SECURITY;

-- Políticas que permiten acceso básico para pruebas (puedes ajustar después)
CREATE POLICY "Acceso completo" ON locales FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo" ON instituciones_educativas FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo" ON mesas FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo" ON alumnos FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo" ON acompanantes FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo" ON registros_comite FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo" ON registro_alumnos FOR ALL USING (true) WITH CHECK (true);
