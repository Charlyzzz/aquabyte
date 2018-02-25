defmodule DesafioImagenes do
  use Application

  def start(_, _) do
    analizar_imagenes()
    {:ok, self()}
  end
  
  defp analizar_imagenes do
    File.cd!('./imagenes')
    File.ls!
      |> Flow.from_enumerable
      |> Flow.filter_map(&Imagen.nombre_valido?/1, &Imagen.desde_nombre_archivo/1)
      |> Flow.group_by(&id_imagen/1)
      |> Flow.map(&reporte_para/1)
      |> Enum.each(&IO.puts/1)
      end

  defp reporte_para({id, grupo}), do: Imagen.reporte_para(id, grupo)

  defp id_imagen({id, _, _, _}), do: id
  defp id_imagen(_), do: nil
end
