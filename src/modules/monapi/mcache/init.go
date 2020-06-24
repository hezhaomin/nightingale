package mcache

func Init() {
	MaskCache = NewMaskCache()
	StraCache = NewStraCache()
	SaCache = NewSaCache()
}
