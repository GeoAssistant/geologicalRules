% trap evaluation from components presence and effectiveness, hc fill

fault_dependent_trap_has_component(top_seal, reservoir, [lateral_seal;fault(f1, sealing)]).
trap(t, fault_dependent_trap).

fault(f1, sealing).
fault(f2, non_sealing).
fault(f3, partially_sealing).
fault(f1, no_migration).
fault(f2, migration).

top_seal(ts1, effective).
top_seal(ts2, non_effective).
top_seal(ts1, no_leakage).
top_seal(ts2, leakage).
top_seal(rock2, shale).
top_seal(ts1, effective):-
    geo_unit_has(facies2, porosity(very_low)),
    geo_unit_has(facies2, permeability(very_low)),
    geo_unit_has(facies2, lateral_continuity(good)).

lateral_seal(ls1, effective).
lateral_seal(ls2, non_effective).
lateral_seal(ls1,no_leakage).
lateral_seal(ls2, leakage).

lithology(top_seal, facies2(shale)).
lithology(lateral_seal, facies2(shale)).
lithology(reservoir, sandstone).


% reservoir_has_lateral_contact(lateral_seal, fault(f1, sealing), [lateral_seal; reservoir]).
reservoir_lateral_contact(r_lc1, lateral_seal).
reservoir_lateral_contact(r_lc2, fault(f1, sealing)).
reservoir_lateral_contact(r_lc3, [lateral_seal; reservoir]).



migration_has_type(vertical_migration, lateral_migration).

vertical_migration(hc_migration_along, f2).
vertical_migration(f2, non-sealing).

no_vertical_migration(f1, sealing).

lateral_migration(hc_migration_through, cb1).
lateral_migration(cb, effective).
no_lateral_migration(t4,underfilled_trap).
no_lateral_migration(f1, sealing).
no_lateral_migration(cb, non-effective).

non_sealing_fault:-
    migration_along_fault = TRUE,
    migration_across_fault= TRUE.

carrier_bed(facies1, sandstone).
carrier_bed(cb, effective):-
    geo_unit_has(facies1, porosity(very_high, high, medium)),
    geo_unit_has(facies1, permeability(very_high, high, medium)),
    geo_unit_has(facies1, lateral_continuity(good, moderate)).
geo_unit_has(facies1, porosity(very_high, high, medium)).
geo_unit_has(facies1, permeability(very_high, high, medium)).
geo_unit_has(facies1, lateral_continuity(very_good, good, moderate)).
geo_unit_has(facies2, porosity(very_low)).
geo_unit_has(facies2, permeability(very_low)).
geo_unit_has(facies2, lateral_continuity(good)).
facies1(lobe).
facies2(basinPlain).

% fault_dependent_trap_has_fill(fill_to_max_structural_closure,fill_to_juxtaposition_point, fill_to_clay_smear_rupture).

% fill_to_spill_trap_has(top_seal(ts1, effective);lateral_seal(ls1,effective); fault(f2,non_sealing); accumulation(acc1,fill_to_spill)).

fill_to_spill_trap(t1):-
    top_seal(ts1,effective);
    fault(f1, sealing),
    fault(f2, non_sealing);
    lateral_seal(ls1, effective).

fill_spill_migration1:-
    trap(t1,fill_to_spill),
    fault(f2, non-sealing),
    trap(t5, no_hc),
    carrier_bed(t2, effective).

fill_spill_migration2:-
    trap(t1,fill_to_juxtaposition_point),
    trap(t5, no_hc),
    carrier_bed(t2, effective).

fill_to_juxtaposition_point_trap(t2):-
    top_seal(ts1,effective),
    lateral_seal(ls1, effective),
    fault(f2, non-sealing),
    reservoir_lateral_contact(r_lc, [lateral_seal;reservoir]).

fill_to_clay_smear_rupture_trap(t3):-
    top_seal(ts1,good),
    fault(f3,partially_sealing).

underfilled_trap(t4):-
     top_seal(ts2, non_effective),
     hc_charge(hc2, insufficient).


hc_charge(hc_charge1, sufficient).
hc_charge(hc_charge2, innsufficient).
