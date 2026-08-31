//
//  RemindersListViewModel.swift
//  CustomerExperience
//
//  Created by Adrian-Zoltan Herczeg on 03.11.2025.
//

import Combine
import BTBusinessCore
import Foundation

/// Presentation layer entity responsible for operating the reminders list page.
final public class RemindersListViewModel: ObservableObject {
  // MARK: - Published Properties

  @Published var uiModel: RemindersListUIModel

  // MARK: - Private Properties

  private var reminders: [Reminder] = []

  private var pendingReminders: [Reminder] {
    reminders.filter { $0.triggerDate > Date() }
      .sorted { $0.triggerDate > $1.triggerDate }
  }

  private var expiredReminders: [Reminder] {
    reminders.filter { $0.triggerDate <= Date() }
      .sorted { $0.triggerDate > $1.triggerDate }
  }

  private let getReminersUsecase: GetRemindersUseCase
  private let removeReminderUsecase: RemoveReminderUseCase
  private let observeReminderNotificationsUsecase: ObserveReminderNotificationsUseCase
  private let mapper = RemindersListUIMapper()
  private var cancellables: Set<AnyCancellable> = []

  // MARK: - Init

  /// Creates a new `RemindersListViewModel`
  /// - Parameter interactor: The interactor associated with the feature.
  public init(
    getRemindersUseCase: GetRemindersUseCase,
    removeReminderUsecase: RemoveReminderUseCase,
    observeReminderNotificationsUsecase: ObserveReminderNotificationsUseCase
  ) {
    self.getReminersUsecase = getRemindersUseCase
    self.removeReminderUsecase = removeReminderUsecase
    self.observeReminderNotificationsUsecase = observeReminderNotificationsUsecase
    uiModel = mapper.makeLoadingState()
    fetchReminders()
    observeNotifications()
  }

  // MARK: - Public Methods

  public func refresh() {
    uiModel = mapper.makeLoadingState()
    fetchReminders()
  }

  // MARK: - Internal Methods

  func handlePendingReminderEdit(at index: Int) {
    // TODO: - Add implementation
  }

  func handlePendingReminderDelete(at index: Int) {
    let correspondingReminder = pendingReminders[index]
    Task {
      try await removeReminderUsecase.removeReminder(id: correspondingReminder.id)
      await MainActor.run {
        fetchReminders()
      }
    }
  }

  func handleExpiredReminderDelete(at index: Int) {
    let correspondingReminder = expiredReminders[index]
    Task {
      try await removeReminderUsecase.removeReminder(id: correspondingReminder.id)
      await MainActor.run {
        fetchReminders()
      }
    }
  }

  // MARK: - Private Methods

  private func observeNotifications() {
    observeReminderNotificationsUsecase.reminderReceivedPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.fetchReminders()
      }
      .store(in: &cancellables)
  }

  private func fetchReminders() {
    Task {
      reminders = try await getReminersUsecase.getReminders()
      await MainActor.run {
        uiModel = mapper.map(
          pendingReminders: pendingReminders,
          expiredReminders: expiredReminders
        )
      }
    }
  }
}
