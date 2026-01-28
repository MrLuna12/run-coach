import { useCallback } from "react"
import { Footprints, Target, Calendar } from "lucide-react"

function Feature({ icon, text }) {
    return (
        <div className="flex items-center gap-3 p-3 rounded-lg bg-secondary">
            <div className="h-8 w-8 rounded-md bg-primary/15 flex items-center justify-center text-primary shrink-0">
                {icon}
            </div>
            <p className="text-sm text-foreground">{text}</p>
        </div>
    )
}

function AppBranding() {
    return (
        <div className="text-center space-y-2">
            <div className="inline-flex items-center justify-center h-14 w-14 rounded-2xl bg-primary mb-4">
                <Footprints className="h-7 w-7 text-primary-foreground" />
            </div>
            <h1 className="text-2xl font-bold tracking-tight text-foreground">
                Run Coach
            </h1>
            <p className="text-muted-foreground text-sm">
                AI-powered running plans built for you
            </p>
        </div>
    )
}

function FeaturesList() {
    const features = [
        {
            id: 1,
            icon: <Target className="h-4 w-4" />,
            text: "Set your race distance and target date"
        },
        {
            id: 2,
            icon: <Calendar className="h-4 w-4" />,
            text: "Get a personalized weekly training plan"
        },
        {
            id: 3,
            icon: <Footprints className="h-4 w-4" />,
            text: "Sync runs from Strava to track progress"
        }
    ]

    return (
        <div className="space-y-3">
            {features.map((feature) => (
                <Feature
                    key={feature.id}
                    icon={feature.icon}
                    text={feature.text}
                />
            ))}
        </div>
    )
}

export function AuthPage() {
    // useCallback to prevent re-creating function on every render
    const handleStravaAuth = useCallback(() => {
        console.log("handleStravaAuth")
    }, [])

    return (
        <div className="min-h-screen bg-background flex items-center justify-center p-6">
            <div className="w-full max-w-sm space-y-8">
                <AppBranding />

                <div className="space-y-6">
                    <FeaturesList />

                    <button
                        onClick={handleStravaAuth}
                        className="w-full flex justify-center"
                        aria-label="Connect with Strava to continue"
                    >
                        <img
                            src="/src/assets/btn_strava_connect_with_orange.svg"
                            alt="Connect with Strava"
                            className="h-12"
                        />
                    </button>

                    <p className="text-xs text-center text-muted-foreground">
                        Your Strava data is only used to generate training plans
                    </p>
                </div>
            </div>
        </div>
    )
}