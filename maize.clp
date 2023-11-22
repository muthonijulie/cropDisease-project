(deftemplate disease
    (slot name)
)

(deftemplate symptom
    (slot disease)
    (slot description)
)

(deftemplate affects
    (slot disease)
    (slot plant-part)
    (slot symptom)
)

(deftemplate diagnosis
    (slot crop)
    (slot plant-part)
    (slot symptom)
    (slot disease)
)

(deftemplate management
    (slot disease)
    (multislot measures)
)

; Facts
(deffacts diseases
    (disease (name black_rot))
    (disease (name corn_smut))
    (disease (name bacterial_leaf_blight))
    (disease (name downy_mildew))
    (disease (name bacterial_leaf_streak))
    (disease (name dwarf_mosaic_virus))
    (disease (name corn_ear_rots))
    (disease (name rust))
)

(deffacts symptoms
    (symptom (disease rust) (description yellow_spots))
    (symptom (disease rust) (description orange_pustules))
    (symptom (disease black_rot) (description dark_spots))
    (symptom (disease black_rot) (description yellow_halo_around_spots))
    (symptom (disease corn_smut) (description swollen_galls))
    (symptom (disease corn_smut) (description dark_galls))
    (symptom (disease bacterial_leaf_blight) (description brown_streaks))
    (symptom (disease bacterial_leaf_blight) (description wilting_leaves))
    (symptom (disease downy_mildew) (description yellow_streaks))
    (symptom (disease corn_ear_rots) (description pink_discoloration))
    (symptom (disease dwarf_mosaic_virus) (description stunted_growth))
    (symptom (disease bacterial_leaf_streak) (description yellow_streaks_in_the_sun))
    (symptom (disease dwarf_mosaic_virus) (description mottled_leaves))
)

(deffacts affects
    (affects (disease rust) (plant-part leaves) (symptom yellow_spots))
    (affects (disease rust) (plant-part leaves) (symptom orange_pustules))
    (affects (disease black_rot) (plant-part leaf) (symptom dark_spots))
    (affects (disease black_rot) (plant-part leaf) (symptom yellow_halo_around_spots))
    (affects (disease corn_smut) (plant-part ears) (symptom swollen_galls))
    (affects (disease corn_smut) (plant-part ears) (symptom dark_galls))
    (affects (disease bacterial_leaf_blight) (plant-part foliages) (symptom brown_streaks))
    (affects (disease bacterial_leaf_blight) (plant-part foliages) (symptom wilting_leaves))
    (affects (disease bacterial_leaf_streak) (plant-part foliages_yellow) (symptom yellow_streaks_in_the_sun))
    (affects (disease dwarf_mosaic_virus) (plant-part stem) (symptom stunted_growth))
    (affects (disease dwarf_mosaic_virus) (plant-part foliage) (symptom mottled_leaves))
)
; Function to get disease name
(deffunction get-disease (?fact)
   (fact-slot-value ?fact name)
)


; Rules
(defrule start-diagnosis
    =>
    (printout t "WELCOME TO CROP DISEASE DIAGNOSIS SYSTEM" crlf)
    (printout t "Enter crop: ")
    (bind ?crop (read))
    (diagnose ?crop)
)
(defrule diagnose
    ?f <- (diagnosis)
    =>
    (retract ?f)
)

(defrule get-plant-part
    ?crop <- (diagnosis (crop ?crop))
    =>
    (printout t "Enter the affected plant part (e.g. leaves): ")
    (bind ?plant-part (read))
    (assert (diagnosis (crop ?crop) (plant-part ?plant-part)))
)

(defrule get-symptom
    ?crop <- (diagnosis (crop ?crop) (plant-part ?plant-part))
    =>
    (printout t "Enter the observed symptom (e.g. yellow_spots): ")
    (bind ?symptom (read))
    (assert (diagnosis (crop ?crop) (plant-part ?plant-part) (symptom ?symptom)))
    (detect-disease ?crop ?plant-part ?symptom)
)

(defrule detect-disease
    ?disease <- (diagnosis (crop ?crop) (plant-part ?plant-part) (symptom ?symptom))
    ?affects <- (affects (disease ?d) (plant-part ?pp) (symptom ?s))
    (test (= ?s ?symptom))
    (test (= ?pp ?plant-part))
    =>
(retract ?disease)  ; Retract the existing diagnosis
    (assert (diagnosis (crop ?crop) (plant-part ?plant-part) (symptom ?symptom) (disease ?d))
    (printout t crlf "Results of the diagnosis:" crlf)
    (printout t "The most likely disease is: " ?d crlf)
    (manage-disease ?d)
    (printout t "Please take appropriate measures to manage the disease." crlf)
    (printout t ".........THANK YOU!......." crlf)
)

(defrule manage-disease
    ?disease <- (diagnosis (disease ?d))
    ?management <- (management (disease ?d) (measures $?measures))
    =>
    (printout t crlf "Management for " ?d ":" crlf)
    (foreach ?measure $?measures (printout t "-" ?measure crlf))
)

