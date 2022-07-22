defmodule LivingWorld.Landmass do
  @moduledoc """
    Generates a 2d landmass that can be rendered
  """

  alias LivingWorld.Noise.LayeredPerlin

  # width, height, persistance, lacunarity, scale
  @doc ~S"""
  Parses the given `line` into a command.

  ## Examples

      iex> LivingWorld.Landmass.Landmass.generate(200, 300)
      %{width: 200, height: 300, options: [scale: 50, lacunarity: 2.5, persistance: 0.5, num_octaves: 3]}

      iex> LivingWorld.Landmass.Landmass.generate(200, 300, num_octaves: 3, persistance: 0.75, lacunarity: 3.5, scale: 25)
      %{width: 200, height: 300, options: [scale: 25, lacunarity: 3.5,persistance: 0.75,  num_octaves: 3]}
  """
  def generate(width, height, seed) do
    # TODO We are ignoring the height for now
    landmass =
      LayeredPerlin.generate(50, 50, seed)
      |> addBiomes

    {:ok, %{width: width, height: height, landmass: landmass}}
  end

  defp addBiomes(landmass) do
    # Loop through and add what the type of landmass it is, e.g. deep sea, mountain
    landmass
    |> Enum.map( fn
      %{"noise" => noise} = data_point when noise < -0.3 -> Map.put(data_point, :land_type, "deep-sea")
      %{"noise" => noise} = data_point when noise < 0 -> Map.put(data_point, :land_type, "sea")
      %{"noise" => noise} = data_point when noise < 0.1 -> Map.put(data_point, :land_type, "sand")
      %{"noise" => noise} = data_point when noise < 0.3 -> Map.put(data_point, :land_type, "grass")
      %{"noise" => noise} = data_point when noise < 0.7 -> Map.put(data_point, :land_type, "trees")
      %{"noise" => noise} = data_point when noise < 0.9 -> Map.put(data_point, :land_type, "mountain")
      data_point -> Map.put(data_point, :land_type, "snow")
    end)
  end
end
