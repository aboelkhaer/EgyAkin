// Fake data for the redesigned home dashboard.
// Replace with API models once the new endpoints are ready.

class HomeDashboardFakeData {
  HomeDashboardFakeData._();

  static const HomeStatsFake stats = HomeStatsFake(
    myPatientsCount: 24,
    myPatientsDelta: 2,
    allPatientsCount: 510,
    allPatientsDelta: 18,
    score: 92,
    scoreDelta: 4,
    updatedLabel: 'Updated just now',
  );

  static const List<HomeConsultationFake> consultations = [
    HomeConsultationFake(
      doctorName: 'Dr. Sara Elhosary',
      doctorInitials: 'DS',
      specialty: 'Nephrology',
      location: 'Mansoura',
      lastMessage: "Let's adjust the dialysis schedule...",
      timeLabel: '9:44',
      unreadCount: 2,
      isOnline: true,
    ),
    HomeConsultationFake(
      doctorName: 'Dr. Mariam Gamal',
      doctorInitials: 'DM',
      specialty: 'Nephrology',
      location: 'SMH',
      lastMessage: "Can you review Eid's latest potass...",
      timeLabel: 'Yesterday',
      unreadCount: 1,
      isOnline: true,
    ),
  ];

  static const List<HomeToolFake> tools = [
    HomeToolFake(label: 'GFR Calc', iconName: 'calculate'),
    HomeToolFake(label: 'Consults', iconName: 'stethoscope'),
    HomeToolFake(label: 'Analytics', iconName: 'analytics'),
    HomeToolFake(label: 'Marked', iconName: 'bookmark'),
  ];

  static const HomeNetworkInsightsFake networkInsights =
      HomeNetworkInsightsFake(
    patientsCount: 510,
    hospitalsCount: 12,
    akiIncidence: 18,
    akiIncidenceDelta: 3,
    mostCommonCause: 'Sepsis',
    mostCommonCausePercent: 32,
    avgEgfr: 38.4,
    avgEgfrNote: 'mL/min · stable',
  );
}

class HomeStatsFake {
  final int myPatientsCount;
  final int myPatientsDelta;
  final int allPatientsCount;
  final int allPatientsDelta;
  final int score;
  final int scoreDelta;
  final String updatedLabel;

  const HomeStatsFake({
    required this.myPatientsCount,
    required this.myPatientsDelta,
    required this.allPatientsCount,
    required this.allPatientsDelta,
    required this.score,
    required this.scoreDelta,
    required this.updatedLabel,
  });
}

class HomeConsultationFake {
  final String doctorName;
  final String doctorInitials;
  final String specialty;
  final String location;
  final String lastMessage;
  final String timeLabel;
  final int unreadCount;
  final bool isOnline;

  const HomeConsultationFake({
    required this.doctorName,
    required this.doctorInitials,
    required this.specialty,
    required this.location,
    required this.lastMessage,
    required this.timeLabel,
    required this.unreadCount,
    required this.isOnline,
  });
}

class HomeToolFake {
  final String label;
  final String iconName;

  const HomeToolFake({
    required this.label,
    required this.iconName,
  });
}

class HomeNetworkInsightsFake {
  final int patientsCount;
  final int hospitalsCount;
  final int akiIncidence;
  final int akiIncidenceDelta;
  final String mostCommonCause;
  final int mostCommonCausePercent;
  final double avgEgfr;
  final String avgEgfrNote;

  const HomeNetworkInsightsFake({
    required this.patientsCount,
    required this.hospitalsCount,
    required this.akiIncidence,
    required this.akiIncidenceDelta,
    required this.mostCommonCause,
    required this.mostCommonCausePercent,
    required this.avgEgfr,
    required this.avgEgfrNote,
  });
}
