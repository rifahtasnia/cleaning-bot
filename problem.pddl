(define (problem Cleaning)
(:domain CleaningBot)
(:objects
	dumptile-1-1 dumptile-1-2 dumptile-1-3 dumptile-2-1 dumptile-2-2 dumptile-2-3 - dirtTiles ; Tiles of dump area
	housetile-1 housetile-2 housetile-3 housetile-4 housetile-5 - houseTiles ; Tiles of house area
	cleanBot - robot
	plastic glass organic - dirt ; dirt objects 
	houseSurface - house_surface
	empty plasticbin glassbin organicbin - dumparea ; dustbin objects
	)

(:init
	; connection between dirt tiles
	(connected dumptile-1-1 dumptile-2-1)
	(connected dumptile-1-1 dumptile-1-2)
	(connected dumptile-1-2 dumptile-2-2)
	(connected dumptile-1-2 dumptile-1-3)
	(connected dumptile-1-2 dumptile-1-1)
	(connected dumptile-1-3 dumptile-2-3)
	(connected dumptile-1-3 dumptile-1-2)
	(connected dumptile-2-1 dumptile-1-1)
	(connected dumptile-2-1 dumptile-2-2)
	(connected dumptile-2-2 dumptile-1-2)
	(connected dumptile-2-2 dumptile-2-3)
	(connected dumptile-2-2 dumptile-2-1)
	(connected dumptile-2-3 dumptile-1-3)
	(connected dumptile-2-3 dumptile-2-2)

	; location of the dustbins
	(in dumptile-1-1 empty)
	(in dumptile-1-2 glassbin)
	(in dumptile-1-3 organicbin)
	(in dumptile-2-1 plasticbin)
	(in dumptile-2-2 empty)
	(in dumptile-2-3 empty)

	; location of the dirts
	(on plastic housetile-1)
	(on glass housetile-2)
	(on organic housetile-3)
	(in plastic houseSurface)
	(in glass houseSurface)
	(in organic houseSurface)

	; housetiles are in house surface
	(in housetile-1 houseSurface)
	(in housetile-2 houseSurface)
	(in housetile-3 houseSurface)
    (in housetile-4 houseSurface)
    (in housetile-5 houseSurface)
    
    ; connection between house tiles
	(connected housetile-1 housetile-2)
    (connected housetile-2 housetile-1)
    (connected housetile-2 housetile-3)
    (connected housetile-3 housetile-2)
    (connected housetile-2 housetile-5)
    (connected housetile-5 housetile-2)  
	(connected housetile-3 housetile-4)
    (connected housetile-4 housetile-3)
    (connected housetile-3 housetile-5)
    (connected housetile-5 housetile-3)
	(connected housetile-4 housetile-5) 
    (connected housetile-5 housetile-4) 
     
    ; House area is connected with dump area through these two tiles.
	(connected dumptile-2-3 housetile-5) 
	(connected housetile-5 dumptile-2-3)  

	; dirt tiles are clear for robot to visit.
	(clear dumptile-1-1)
	(clear dumptile-1-2)
	(clear dumptile-2-3)
	(clear dumptile-2-1) 
	
	; house tiles are clear for robot to visit.
	(clear housetile-1)
	(clear housetile-2)
	(clear housetile-3)
	(clear housetile-4) 
	(clear housetile-5) 

	(at cleanBot dumptile-1-3) ; initial position of cleanBot
	(available cleanBot) ; cleanBot is available
	)

(:goal (and
	(in plastic plasticbin)
	(in glass glassbin)
	(in organic organicbin)
	))
)