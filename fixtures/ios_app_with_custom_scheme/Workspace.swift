import ProjectDescription

let customAppScheme: Scheme = .scheme(
    name: "Workspace-App",
    shared: true,
    buildAction: .buildAction(
        targets: [
            .project(path: "App", target: "App"),
            .project(path: "Frameworks/Framework1", target: "Framework1"),
        ],
        preActions: [
            .executionAction(
                scriptText: "echo \"pre-action in $SHELL\"",
                target: .project(path: "App", target: "App"),
                shellPath: "/bin/zsh"
            ),
        ],
        postActions: [
            .executionAction(
                scriptText: "echo \"post-action in $SHELL\"",
                target: .project(path: "Frameworks/Framework1", target: "Framework1"),
                shellPath: "/bin/zsh"
            ),
        ]
    ),
    testAction: TestAction.targets(
        [
            .testableTarget(target: .project(path: "App", target: "AppTests")),
            .testableTarget(target: .project(
                path: "Frameworks/Framework1",
                target: "Framework1Tests"
            )),
            .testableTarget(target: .project(
                path: "Frameworks/Framework2",
                target: "Framework2Tests"
            )),
        ],
        options: .options(preferredScreenCaptureFormat: .screenshots)
    ),
    runAction: .runAction(
        executable: .project(path: "App", target: "App"),
        arguments: .arguments(environmentVariables: ["path": "$(SRCROOT)"], launchArguments: []),
        options: .options(
            storeKitConfigurationPath: "App/Config/ProjectStoreKitConfig.storekit"
        ),
        expandVariableFromTarget: .project(path: "Frameworks/Framework1", target: "Framework1")
    ),
    archiveAction: .archiveAction(configuration: "Debug", customArchiveName: "Something2")
)

let customAppSchemeWithTestPlans: Scheme = .scheme(
    name: "Workspace-App-With-TestPlans",
    shared: true,
    buildAction: .buildAction(
        targets: [.project(path: "App", target: "App")],
        preActions: []
    ),
    testAction: TestAction
        .testPlans([
            "DefaultTestPlan.xctestplan",
            "OtherTestPlan.xctestplan",
            "YetAnotherTestPlan.xctestplan",
            "NonExistentTestPlan.xctestplan",
        ]),
    runAction: .runAction(executable: .project(path: "App", target: "App")),
    archiveAction: .archiveAction(configuration: "Debug", customArchiveName: "Something2")
)

let customFrameworkScheme: Scheme = .scheme(
    name: "Workspace-Framework",
    shared: true,
    buildAction: .buildAction(
        targets: [.project(path: "Frameworks/Framework1", target: "Framework1")],
        preActions: []
    ),
    testAction: TestAction
        .targets([.testableTarget(target: .project(
            path: "Frameworks/Framework1",
            target: "Framework1Tests"
        ))]),
    archiveAction: .archiveAction(configuration: "Debug", customArchiveName: "Something2")
)

let workspace = Workspace(
    name: "Workspace",
    projects: [
        "App",
        "Frameworks/**",
    ],
    schemes: [
        customAppScheme,
        customAppSchemeWithTestPlans,
        customFrameworkScheme,
    ]
)
