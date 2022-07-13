defmodule LivingWorld.Landmass.Landmass do
  @moduledoc """
    Generates a 2d landmass that can be rendered
  """

  @default_options [num_octaves: 3, persistance: 0.5, lacunarity: 2.5, scale: 50]

  # width, height, persistance, lacunarity, scale
  @doc ~S"""
  Parses the given `line` into a command.

  ## Examples

      iex> LivingWorld.Landmass.Landmass.generate(200, 300)
      %{width: 200, height: 300, options: [scale: 50, lacunarity: 2.5, persistance: 0.5, num_octaves: 3]}

      iex> LivingWorld.Landmass.Landmass.generate(200, 300, num_octaves: 3, persistance: 0.75, lacunarity: 3.5, scale: 25)
      %{width: 200, height: 300, options: [scale: 25, lacunarity: 3.5,persistance: 0.75,  num_octaves: 3]}
  """
  def generate(width, height, options \\ []) do
    options = Keyword.validate!(options, @default_options)

    %{width: width, height: height, options: options}
  end
end
