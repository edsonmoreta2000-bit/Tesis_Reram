File {
    Grid    = "@tdr@"
    Plot    = "FORMING_V3_final.tdr"
    Current = "FORMING_V3.plt"
    Output  = "FORMING_V3.out"
    Param = "reram_repro_v3.par"
}

Electrode {
    { name="top"    voltage=0.0 Material="TiN" }
    { name="bottom" voltage=0.0 Material="TiN" }
}

Thermode {
    { name="top"    temperature=300 }
    { name="bottom" temperature=300 }
}

Plot {
    VertexIndex
    Potential
    ElectricField
    eDensity
    hDensity
    TotalCurrent
    ReRAMParticle
    ReRAMPotential
    ReRAMTemperature
    ReRAMField
    ReRAMCurrent
    ConductionBandEnergy
    ValenceBandEnergy
}

Physics {
    Temperature = 300
    AreaFactor  = 0.085

    Traps(( KmcReram ))

    KMCDefects(
        ConductanceEquation
        HeatEquation
        Particle1(Name="Oxygen")
        Particle2(Name="Vacancy")
        Filament1(Name="ImmobileVacancy")
    )
}

Physics (Region = "Weak.HfO2") {
    KMCDefects(
        FilamentSeeds(Filament1)

        FrenkelPair1(
            Particle1(Region="Weak.HfO2")
            Particle2(Region="Weak.HfO2")
            SameSite
        )

        Generation(
            FrenkelPair1(
                Frequency = 2e8
                Ea        = 1.443
                Dipole    = 2e-7
            )
        )

        Recombination(
            FrenkelPair1(
                Frequency = 1e7
                Ea        = 0.75
                Dipole    = 0
            )
        )

        Diffusion(
            Particle1(
                Frequency = 8e9
                Ea        = 0.65
                Dipole    = -1e-6
            )
        )

        Diffusion(
            Particle2(
                Frequency = 8e9
                Ea        = 0.65
                Dipole    = 1e-6
            )
        )

        FilamentGrowth(
            Filament1(
                Frequency = 5e10
                Ea        = 0.65
                Dipole    = 4e-6
                Particle2
            )
        )
    )
}

Physics (Region = "SwitchGap.HfO2") {
    KMCDefects(
        FilamentSeeds(Filament1)

        FrenkelPair1(
            Particle1(Region="SwitchGap.HfO2")
            Particle2(Region="SwitchGap.HfO2")
            SameSite
        )

        Generation(
            FrenkelPair1(
                Frequency = 2e8
                Ea        = 1.443
                Dipole    = 2e-7
            )
        )

        Recombination(
            FrenkelPair1(
                Frequency = 1e7
                Ea        = 0.75
                Dipole    = 0
            )
        )

        Diffusion(
            Particle1(
                Frequency = 8e9
                Ea        = 0.65
                Dipole    = -1e-6
            )
        )

        Diffusion(
            Particle2(
                Frequency = 8e9
                Ea        = 0.65
                Dipole    = 1e-6
            )
        )

        FilamentGrowth(
            Filament1(
                Frequency = 5e10
                Ea        = 0.65
                Dipole    = 4e-6
                Particle2
            )
        )
    )
}

Physics (Region = "Hf.reservoir") {
    KMCDefects(
        Diffusion(
            Particle1(
                Frequency = 8e9
                Ea        = 0.65
                Dipole    = -1e-6
            )
        )
    )
}

Physics (Electrode = "top") {
    KMCDefects(FilamentSeeds(Filament1))
}

Physics (Electrode = "bottom") {
    KMCDefects(FilamentSeeds(Filament1))
}

Math {
    Extrapolate
    NumberOfThreads = 1
    Iterations = 40
    transient = BE

    KMC(
        RandomSeed = 1
        CurrentCompliance(
            Contact = "top"
            MinVal  = -55e-6
            MaxVal  =  55e-6
        )
        MinLocation = (0.000, -0.003, 0.039)
        MaxLocation = (0.075,  0.003, 0.046)
        CellLength = 0.0005
        UseKMCTimeStep
        MaxTrapNumberChange = 1
        MaxTrapNumber = 7000
        TargetParticle(Filament1)
    )
}

Solve {
    Coupled(Iterations=30) {
        Poisson Electron Hole Contact
    }

    Transient(
        InitialTime = 0.0
        FinalTime   = 0.10
        InitialStep = 0.00025
        Increment   = 1.2
        Decrement   = 2.0
        MinStep     = 1e-8
        MaxStep     = 0.001
        Goal { Name="top" Voltage=3.0 }
    ) {
        Coupled(Iterations=30) {
            Poisson Electron Hole Contact
        }
        Plot(FilePrefix="FORMING_V3_early" Time=(0.00025))
    }
}
