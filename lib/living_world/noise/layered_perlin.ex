defmodule LivingWorld.Noise.LayeredPerlin do
  @moduledoc """
  Layred perline noise. This is useful for generated landmasses
  """

  alias LivingWorld.Noise.ClassicNoise

  @default_settings %{lacunarity: 2.5, num_octaves: 3, persistance: 0.5, scale: 50}

  def generate(width, height, seed, settings \\ @default_settings) do
    # We have a 2d map, so we can hijack the z-axis as a pseudo seed
    z = 10*seed
    for x <- 0..width, y <- 0..height do
      layered_noise_at_point(x, y, z, settings)
    end
    |> normalise
  end

  # This is the layering part. Each octave is a layer.
  defp layered_noise_at_point(x, y, z, settings) do
    0..(settings.num_octaves - 1)
    |> Enum.reduce(
      %{
        amplitude: 1,
        frequency: 1,
        value: 0
      },
      fn _, %{amplitude: amplitude, frequency: frequency, value: value} ->
        %{
          amplitude: amplitude * settings.persistance,
          frequency: frequency * settings.lacunarity,
          value: value + noise_at_point(x, y, z, settings.scale, amplitude, frequency)
        }
      end
    )
    |> then(& &1.value)
    |> then(&
      %{
        "x" => x / settings.scale, # Is this right? You'll work it out when zooming
        "y" => y / settings.scale,
        "screen_x" => x,
        "screen_y" => y,
        "noise" => &1
      }
    )
  end

  defp noise_at_point(x, y, z, scale, amplitude, frequency) do
    sample_x = x / scale * frequency
    sample_y = y / scale * frequency
    sample_z = z / scale * frequency

    amplitude * ClassicNoise.noise(sample_x, sample_y, sample_z)
  end

  defp normalise(octaves) do
    {min_noise, max_noise} =
      octaves
      |> Enum.reduce({nil, nil}, fn
        %{"noise" => noise}, {nil, nil} ->
          {noise, noise}

        %{"noise" => noise}, {min_noise, max_noise} when noise > max_noise ->
          {min_noise, noise}

        %{"noise" => noise}, {min_noise, max_noise} when noise < min_noise ->
          {noise, max_noise}

        _, acc ->
          acc
      end)

    octaves
    |> Enum.map(fn %{"noise" => noise} = data_point ->
      scaled_noise_point = scale_value(noise, min_noise, max_noise, -1, 1)
      Map.put(data_point, "noise", scaled_noise_point)
    end)
  end

  defp scale_value(num, in_min, in_max, out_min, out_max) do
    (num - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
  end
end
