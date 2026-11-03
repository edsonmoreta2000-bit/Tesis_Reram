Controls {
}

IOControls {
    inputFile = "sde_dvs.tdr"
    EnableSections
}

Definitions {
    Refinement "R.Global" {
        MaxElementSize = ( 0.006 0.008 )
        MinElementSize = ( 0.001 0.001 )
    }

    Refinement "R.TiN.Bulk" {
        MaxElementSize = ( 0.004 0.006 )
        MinElementSize = ( 0.001 0.001 )
    }

    Refinement "R.Hf.Bulk" {
        MaxElementSize = ( 0.002 0.004 )
        MinElementSize = ( 0.0005 0.001 )
    }

    Refinement "R.HfO2" {
        MaxElementSize = ( 0.0005 0.001 )
        MinElementSize = ( 0.00025 0.0005 )
    }

    Refinement "R.Weak.HfO2" {
        MaxElementSize = ( 0.00025 0.00025 )
        MinElementSize = ( 0.000125 0.000125 )
    }

    Refinement "R.SwitchGap.HfO2" {
        MaxElementSize = ( 0.000125 0.00025 )
        MinElementSize = ( 0.000125 0.000125 )
    }
}

Placements {
    Refinement "P.Global" {
        Reference = "R.Global"
        RefineWindow = Rectangle [
            (0.000 -0.0425)
            (0.075  0.0425)
        ]
    }

    Refinement "P.TiN.Top" {
        Reference = "R.TiN.Bulk"
        RefineWindow = Rectangle [
            (0.000 -0.0425)
            (0.030  0.0425)
        ]
    }

    Refinement "P.HfO2" {
        Reference = "R.HfO2"
        RefineWindow = Rectangle [
            (0.030 -0.0425)
            (0.035  0.0425)
        ]
    }

    Refinement "P.Weak.HfO2" {
        Reference = "R.Weak.HfO2"
        RefineWindow = Rectangle [
            (0.030 -0.0025)
            (0.034  0.0025)
        ]
    }

    Refinement "P.SwitchGap.HfO2" {
        Reference = "R.SwitchGap.HfO2"
        RefineWindow = Rectangle [
            (0.034 -0.0025)
            (0.035  0.0025)
        ]
    }

    Refinement "P.Hf.Bulk" {
        Reference = "R.Hf.Bulk"
        RefineWindow = Rectangle [
            (0.035 -0.0425)
            (0.045  0.0425)
        ]
    }

    Refinement "P.TiN.Bottom" {
        Reference = "R.TiN.Bulk"
        RefineWindow = Rectangle [
            (0.045 -0.0425)
            (0.075  0.0425)
        ]
    }
}