(define (domain CleaningBot)
(:requirements :typing)
(:types robot surface place area dirt - object
	house_surface dumparea - place
	dirtTiles home houseTiles - area )

(:predicates (clear ?s - (either dirtTiles houseTiles))
	     (in ?x - (either dirtTiles dirt houseTiles) ?p - place)
	     (available ?r - robot) 
	     (grabing ?r - robot ?d - dirt) 
	     (at ?r - robot ?a - area)
	     (on ?d - dirt ?s - (either dirtTiles houseTiles)) 
	     (connected ?a1 ?a2 - area)) 

;With this action the robot will grab the dirt from the house tile. 
;Precondition of grabbing a dirt object is that the bot's hand needs to be available and 
;the bot needs to be on any tile that is directly connected to the tile where dirt is present.
;effect will be that robot's hand will become unavailable
(:action grab
 :parameters (?r - robot ?d - dirt ?a1 - houseTiles ?a2 - area ?p - place)
 :precondition (and (connected ?a1 ?a2) (at ?r ?a2) (available ?r) 
		    (on ?d ?a1) (in ?a1 ?p))
 :effect (and (not (on ?d ?a1)) (clear ?a1)
	      (not (available ?r)) (grabing ?r ?d) (not (in ?d ?p))))


; With this action the robot will drop the dirt into the dustbins according to the nature of the dirt. 
; Precondition of dropping a dirt object is that the bot needs to be on any tile that is directly connected to the tile where the particular dustbin is present.	
; Effect will be that the robot's hand will be available after dropping the object.			
(:action drop
 :parameters (?r - robot ?d - dirt ?a1 - dirtTiles ?a2 - area ?p - place)
 :precondition (and (connected ?a1 ?a2) (at ?r ?a2) (grabing ?r ?d) 
		    (clear ?a1) (in ?a1 ?p))
 :effect (and (not (grabing ?r ?d)) (available ?r)
	      (not (clear ?a1)) (on ?d ?a1) (in ?d ?p)))


; navigations of the cleaning bot in the area where dustbins are kept, outside the house area. 
(:action move
 :parameters (?r - robot ?from ?to - dirtTiles)
 :precondition (and (at ?r ?from) (clear ?to) (connected ?from ?to))
 :effect (and (not (at ?r ?from)) (at ?r ?to) (not (clear ?to)) (clear ?from)))
 
; cleaning bot’s navigation inside the house area where dirts are present.
 (:action move-inside
 :parameters (?r - robot ?from ?to - houseTiles)
 :precondition (and (at ?r ?from) (clear ?to) (connected ?from ?to))
 :effect (and (not (at ?r ?from)) (at ?r ?to) (not (clear ?to))))

; The robot will go inside the house to grab the dirt. This action will work when it will find the connection between a dirtTile and houseTile. 
(:action go-in
 :parameters (?r - robot ?from - dirtTiles ?to - houseTiles)
 :precondition (and (at ?r ?from) (connected ?from ?to))
 :effect (and (not (at ?r ?from)) (at ?r ?to) (clear ?from)))

; When a dirt object is already in the robot's hand it will find the connection between houseTile and dirtTile to drop the object in dustbin.
(:action go-out
 :parameters (?r - robot ?from - houseTiles ?to - dirtTiles)
 :precondition (and (at ?r ?from) (connected ?from ?to) (clear ?to))
 :effect (and (not (at ?r ?from)) (at ?r ?to) (not (clear ?to))))
)

