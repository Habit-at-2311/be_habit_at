class PlantSerializer
	include JSONAPI::Serializer

	attributes :style, :stem, :seed, :petal, :leaf, :scale
end