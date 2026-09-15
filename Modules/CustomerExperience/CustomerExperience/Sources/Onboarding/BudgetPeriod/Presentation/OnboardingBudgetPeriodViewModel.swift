//
//  OnboardingBudgetPeriodViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 02.09.2026.
//

import Foundation
import Combine
import BTBusinessCore

/// Presentation layer entity responsible for the screen displaying the inital budget configuration screen.
///
/// This is the last configuration step, so it owns building the ``BudgetPlanCreationDM`` from the
/// accumulated selections and persisting it through ``CreateInitialPlanUseCase``. Navigation to the
/// success screen is only signalled after the use case succeeds.
public final class OnboardingBudgetPeriodViewModel: ObservableObject {
  // MARK: - Nested Types

  /// Entity indicating the events produced by this view model.
  public enum OutputEvent: Equatable {
    /// Signal emited when the user requested navigation back to the previous step.
    case backRequested
    /// Signal emited once the initial budget plan has been persisted, carrying the created plan.
    case planCreated(BudgetPlanDM)
  }

  // MARK: - Published Properties

  @Published var uiModel: OnboardingBudgetPeriodUIModel
  @Published private(set) var isCreatingPlan = false
  @Published var hasCreationError = false

  /// The start date picked by the user. Seeded to ``minimumStartDate`` and never allowed earlier.
  @Published var selectedStartDate: Date {
    didSet { remapUIModel() }
  }

  // MARK: - Public Properties

  public var eventsPublisher: AnyPublisher<OutputEvent, Never> {
    eventsSubject.eraseToAnyPublisher()
  }

  /// The earliest date the user may pick: the start of the day after `now` — used as the
  /// `DatePicker`'s lower bound.
  public let minimumStartDate: Date

  // MARK: - Private Properties

  private let dataProvider: OnboardingSelectionDataProvider
  private let createInitialPlanUseCase: CreateInitialPlanUseCase
  private let calendar: Calendar
  private let locale: Locale
  private let mapper = OnboardingBudgetPeriodUIMapper()
  private let eventsSubject = PassthroughSubject<OutputEvent, Never>()

  /// The picked date normalised to the start of its day — the value that is rendered and persisted.
  private var normalizedStartDate: Date {
    calendar.startOfDay(for: selectedStartDate)
  }

  /// Defensive "next day only" gate — the constrained picker cannot produce an earlier date, but
  /// this guards the build per the onboarding validation requirement.
  private var isStartDateValid: Bool {
    normalizedStartDate >= minimumStartDate
  }

  // MARK: - Init

  /// Creates a new `OnboardingBudgetPeriodViewModel`.
  /// - Parameters:
  ///   - dataProvider: Accumulates the values entered across the onboarding steps.
  ///   - createInitialPlanUseCase: Persists the assembled budget plan.
  ///   - now: Reference date used to derive the earliest selectable date. Injectable for tests.
  ///   - calendar: Calendar used for the period math. Injectable for tests.
  ///   - locale: Locale used to format the rendered dates. Injectable for tests.
  public init(
    dataProvider: OnboardingSelectionDataProvider,
    createInitialPlanUseCase: CreateInitialPlanUseCase,
    now: Date = .now,
    calendar: Calendar = .current,
    locale: Locale = .current
  ) {
    self.dataProvider = dataProvider
    self.createInitialPlanUseCase = createInitialPlanUseCase
    self.calendar = calendar
    self.locale = locale

    let minimumStartDate = OnboardingBudgetPeriodHelper.startDate(now: now, calendar: calendar)
    self.minimumStartDate = minimumStartDate
    self.selectedStartDate = minimumStartDate
    self.uiModel = mapper.map(startDate: minimumStartDate, calendar: calendar, locale: locale)
  }

  // MARK: - Internal Methods

  func handleBackTap() {
    eventsSubject.send(.backRequested)
  }

  func handleCreateTap() {
    guard !isCreatingPlan, isStartDateValid else { return }

    let creationDM = dataProvider.build(startDate: normalizedStartDate, calendar: calendar)
    isCreatingPlan = true

    Task { [weak self] in
      guard let self else { return }
      do {
        let plan = try await createInitialPlanUseCase.createInitialPlan(creationDM)
        await MainActor.run {
          self.isCreatingPlan = false
          self.eventsSubject.send(.planCreated(plan))
        }
      } catch {
        await MainActor.run {
          self.isCreatingPlan = false
          self.hasCreationError = true
        }
      }
    }
  }

  // MARK: - Private Methods

  private func remapUIModel() {
    uiModel = mapper.map(startDate: normalizedStartDate, calendar: calendar, locale: locale)
  }
}
