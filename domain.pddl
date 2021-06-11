;;Domain for cleaning floor tiles
;; A domain file for CMP2020M assignment 2018/2019

;; Define the name for this domain (needs to match the domain definition
;;   in the problem files)

(define (domain floor-tile)

	;; We only require some typing to make this plan faster. We can do without!
	(:requirements :typing)

	;; We have two types: robots and the tiles, both are objects
	(:types robot tile - object)

	;; define all the predicates as they are used in the probem files
	(:predicates  

    ;; described what tile a robot is at
    (robot-at ?r - robot ?x - tile)

    ;; indicates that tile ?x is above tile ?y
    (up ?x - tile ?y - tile)

    ;; indicates that tile ?x is below tile ?y
    (down ?x - tile ?y - tile)

    ;; indicates that tile ?x is right of tile ?y
    (right ?x - tile ?y - tile)

    ;; indicates that tile ?x is left of tile ?y
    (left ?x - tile ?y - tile)
    
    ;; indicates that a tile is clear (robot can move there)
    (clear ?x - tile)

    ;; indicates that a tile is cleaned
    (cleaned ?x - tile)
 	)


;;There was a problem with the website where it sometimes displays 2 as the output, if you encouter this please just press the solve it button again and it fixes it, the outpus should be 7 and 22 respectively

;;First 2 actions are for cleaning the tiles

(:action clean-up																				;;The parameters contains objects which are instances of types defined in the domain file
          :parameters(?r - robot ?y - tile ?x - tile)											;;This defines the objects that clean-up can use
          :precondition(and (up ?x ?y) (clear ?x) (robot-at ?r ?y) (not (cleaned ?x)))			;;These are the conditions needed for the code to run, the space needs to be clear not already cleaned and above the robot
          :effect(and (cleaned ?x) (robot-at ?r ?y))											;;This is what happens when the precondition is met

 )

 (:action clean-down
          :parameters(?r - robot ?y - tile ?x - tile)											;;This 2nd action is very similar to the first one, the main difference is in precondition where up is turened to down, this is because the action is similar
          :precondition(and (down ?x ?y) (clear ?x) (robot-at ?r ?y) (not (cleaned ?x)))		;;The precondition is the initial state of the world before starting the planning process
          :effect(and (cleaned ?x) (robot-at ?r ?y))											;;The effect part are the properties of the world true in goal states and achieved after the planning process

 )

;;The last 4 actions are for moving the robot
 
 (:action up
          :parameters (?y - tile ?x - tile ?r - robot)											;;The paramaters and preconditions are the same as the same information for cleaning is needed for moving
          :precondition (and  (up ?x ?y) (robot-at ?r ?y) (clear ?x) (not (cleaned ?x)))		;;It does the same checks as the previous 2 actions
          :effect (and (not (clear ?x)) (clear ?y) (not (robot-at ?r ?y)) (robot-at ?r ?x))		;;The effect is different as this action changes the location of the robot and clear
 )

 (:action down
          :parameters (?y - tile ?x - tile ?r - robot)											;;The rest of these actions are essentially the same as action up, 
          :precondition (and  (down ?x ?y)(robot-at ?r ?y) (clear ?x) (not (cleaned ?x)))		;;This is because the same effect happens each time and the same paramaters are used
          :effect (and (not (clear ?x)) (clear ?y) (not (robot-at ?r ?y)) (robot-at ?r ?x))		;;The only difference is in the preconditions, where it needs to check a different space each time, up, down, left or right
 )
 
(:action left
          :parameters (?y - tile ?x - tile ?r - robot)
          :precondition (and  (left ?x ?y)(robot-at ?r ?y) (clear ?x) (not (cleaned ?x)))
          :effect (and (not (clear ?x)) (clear ?y) (not (robot-at ?r ?y)) (robot-at ?r ?x))
 )
 
(:action right
          :parameters (?y - tile ?x - tile ?r - robot)
          :precondition (and  (right ?x ?y)(robot-at ?r ?y) (clear ?x) (not (cleaned ?x)))
          :effect (and  (not (clear ?x)) (clear ?y) (not (robot-at ?r ?y)) (robot-at ?r ?x))
 )
)
;;References: 
;;users.cecs.anu.edu.au. (n.d.). Writing Planning Domains and Problems in PDDL. [online] Available at: http://users.cecs.anu.edu.au/~patrik/pddlman/writing.html. [Accesed April 20th 2020]
;;Helmert, M. (n.d.). An Introduction to PDDL. [online] Available at: http://www.cs.toronto.edu/~sheila/2542/s14/A1/introtopddl2.pdf. [Accesed April 24th 2020]
;;Week 9-10 Lectures and Workshops
;;GitHub. (n.d.). pellierd/pddl4j. [online] Available at: https://github.com/pellierd/pddl4j/wiki/A-tutorial-to-start-with-PDDL. [Accesed April 21th 2020]
;;Helmert, M. (n.d.). Concise finite-domain representations for PDDL planning tasks. core.ac.uk. [online] Available at: https://core.ac.uk/reader/82800940. [Accesed April 20th 2020]