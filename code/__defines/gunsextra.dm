//
//PS13 Calibers defines (don't rename file otherwise the defines will be overriden by the bay original)
//
#define CALIBER_556MM            "5.56mm"
#define CALIBER_762MM            "7.62mm"
#define CALIBER_9MM              "9mm"
#define CALIBER_10MM             "10mm"
#define CALIBER_145MM            "14.5mm"
#define CALIBER_20MM             "20mm"
#define CALIBER_22LR             ".22lr"
#define CALIBER_223              ".223"
#define CALIBER_357              ".357"
#define CALIBER_38               ".38"
#define CALIBER_44               ".44"
#define CALIBER_45               ".45"
#define CALIBER_50               ".50"
#define CALIBER_12G              "12g"
#define CALIBER_40MM_ROCKET      "40mm_rocket"

//Redef a bunch of bay defines
#ifdef CALIBER_PISTOL
	#undef CALIBER_PISTOL
#endif
#define CALIBER_PISTOL 			CALIBER_45

#ifdef CALIBER_PISTOL_SMALL
	#undef CALIBER_PISTOL_SMALL
#endif
#define CALIBER_PISTOL_SMALL 	CALIBER_9MM

#ifdef CALIBER_PISTOL_MAGNUM
	#undef CALIBER_PISTOL_MAGNUM
#endif
#define CALIBER_PISTOL_MAGNUM 	CALIBER_357

#ifdef CALIBER_RIFLE
	#undef CALIBER_RIFLE
#endif
#define CALIBER_RIFLE			CALIBER_762MM

#ifdef CALIBER_RIFLE_MILITARY
	#undef CALIBER_RIFLE_MILITARY
#endif
#define CALIBER_RIFLE_MILITARY  CALIBER_556MM

#ifdef CALIBER_ANTIMATERIAL
	#undef CALIBER_ANTIMATERIAL
#endif
#define CALIBER_ANTIMATERIAL    CALIBER_145MM

#ifdef CALIBER_SHOTGUN
	#undef CALIBER_SHOTGUN
#endif
#define CALIBER_SHOTGUN			CALIBER_12G //Typically 12G