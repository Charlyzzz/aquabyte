defmodule Imagen do
  
  def nombre_valido?(nombre_archivo) do
    regex_nombre = ~r/^((left)|(right))_\d+\.png$/   
    Regex.match?(regex_nombre, nombre_archivo)
  end
  
  def desde_nombre_archivo(nombre) do
    if imagen_png_íntegra?(nombre) do 
      valida_desde_nombre_archivo(nombre)
    else
      invalida_desde_nombre_archivo(nombre)
    end
  end

  def reporte_para(nil, imagenes_corruptas) do
    "Se encontraron las siguientes imágenes corruptas: #{Enum.join(imagenes_corruptas, ", ")}"
  end
  
  def reporte_para(id, [imagen, pareja]) do
    if mismo_tamaño?(imagen, pareja) do
      "Se encontró una pareja con id #{id} y mismo tamaño (#{tamaño(imagen)})"
    else
      "Se encontró una pareja con id #{id} y distinto tamaño (#{tamaño(imagen)} vs #{tamaño(pareja)})"
    end
  end

  def reporte_para(id, [_]) do
    "La imagen con id #{id} es huérfana"
  end

  defp mismo_tamaño?(imagen, otraImagen), do: tamaño(imagen) == tamaño(otraImagen)
  
  defp tamaño({_, _, ancho, alto}), do: "#{ancho}x#{alto}"
  
  defp imagen_png_íntegra?(nombre_archivo) do
    nombre_archivo
    |> leer_imagen
    |> ExImageInfo.seems?(:png)
  end
  
  defp valida_desde_nombre_archivo(nombre) do
    {_, ancho, alto, _} = nombre
    |> leer_imagen
    |> ExImageInfo.info
    {id_desde_el_nombre(nombre), nombre, ancho, alto}
  end
  
  defp invalida_desde_nombre_archivo(nombre) do
    nombre
  end
  
  defp leer_imagen(nombre_archivo), do: File.read!(nombre_archivo)
 
  defp id_desde_el_nombre(nombre) do
    [_, resto] = String.split(nombre, "_")
    Integer.parse(resto) |> elem(0)
  end
end