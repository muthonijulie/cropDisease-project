disease(black_rot).
disease(corn_smut).
disease(bacterial_leaf_blight).
disease(downy_mildew).
disease(bacterial_leaf_streak).
disease(dwarf_mosaic_virus).
disease(corn_ear_rots).
disease(rust).
symptom(rust, yellow_spots).
symptom(rust, orange_pustules).
symptom(black_rot, dark_spots).
symptom(black_rot, yellow_halo_around_spots).
symptom(corn_smut, swollen_galls).
symptom(corn_smut, dark_galls).
symptom(bacterial_leaf_blight, brown_streaks).
symptom(bacterial_leaf_blight, wilting_leaves).
symptom(downy_mildew, yellow_streaks).
symptom(corn_ear_rots, pink_discoloration).
symptom(dwarf_mosaic_virus, stunted_growth).
symptom(bacterial_leaf_streak, yellow_streaks_in_the_sun).
symptom(dwarf_mosaic_virus, mottled_leaves).



affects(rust, leaves, yellow_spots).
affects(rust, leaves, orange_pustules).
affects(black_rot, leaf, dark_spots).
affects(black_rot, leaf, yellow_halo_around_spots).
affects(corn_smut, ears, swollen_galls).
affects(corn_smut, ears, dark_galls).
affects(bacterial_leaf_blight, foliages, brown_streaks).
affects(bacterial_leaf_blight, foliages, wilting_leaves).
affects(bacterial_leaf_streak, foliages_yellow, yellow_streaks_in_the_sun).
affects(dwarf_mosaic_virus,stem, stunted_growth).
affects(dwarf_mosaic_virus,foliage, mottled_leaves).

detect_disease(PlantPart, Disease) :-
       symptom(Disease,Symptom),
       affects(Disease, PlantPart, Symptom).

start_diagnosis :-
    write('WELCOME TO CROP DISEASE DIAGNOSIS SYSTEM'),nl,
    write('Enter crop:'),
    read(Crop),nl,
    get_plant_part(PlantPart),
    get_symptom(Symptom),
    detect_disease(PlantPart, Disease),
    display_diagnosis(Disease).

get_plant_part(PlantPart) :-
    write('Enter the affected plant part (e.g.leaves): '),
    read(PlantPart).

get_symptom(Symptom) :-
    write('Enter the observed symptom (e.g.yellow_spots): '),
    read(Symptom).

manage_disease(rust) :-
    write('Management for rust:'), nl,
    write('- Use fungicides as a preventive measure.'), nl,
    write('- Remove and destroy infected plant parts.'), nl.

manage_disease(black_rot) :-
    write('Management for black rot:'), nl,
    write('- Prune infected plant parts to reduce the spread.'), nl,
    write('- Apply fungicides early in the growing season.'), nl.
manage_disease(corn_smut) :-
    write('Management for corn smut:'), nl,
    write('- Practice crop rotation to reduce disease pressure.'), nl,
    write('- Use fungicides as a preventive measure in high-risk areas.'), nl.

manage_disease(bacterial_leaf_blight) :-
    write('Management for bacterial leaf blight:'), nl,
    write('- Avoid overhead irrigation to reduce humidity.'), nl,
    write('- Use disease-resistant plant varieties if available.'), nl.
manage_disease(dwarf_mosaic_virus) :-
    write('Management for Dwarf Mosaic Virus:'), nl,
    write('- Plant virus-resistant crop varieties if available.'), nl,
    write('- Implement crop rotation to break the virus cycle.'), nl.
manage_disease(bacterial_leaf_streak) :-
    write('Management for Bacterial leaf streak:'), nl,
    write('-Use drip irrigation.'),nl,
    write('-Control weeds that may harbor the bacteria and serve as alternative hosts.'),nl.
manage_disease(downy_mildew) :-
    write('Management for Downy mildew:'), nl,
write(-'Use downy mildew-resistant plant varieties whenever possible.'),nl,
write('-Apply fungicides.'),nl.
display_diagnosis(Disease) :-
    nl,
    write('Results of the diagnosis:'), nl,
    write('The most likely disease is: '), write(Disease), nl,
    manage_disease(Disease),
    write('Please take appropriate measures to manage the disease.'), nl,
    write('.........THANK YOU!.......').
