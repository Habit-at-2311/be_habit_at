class PlantSerializer
	include JSONAPI::Serializer

	attributes :style, :stem, :seed, :petal, :leaf, :grow_rate, :scale
end
