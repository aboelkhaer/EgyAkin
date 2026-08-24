// Fake data for the redesigned Inbox tab.
// Replace with API models once messaging endpoints are ready.

enum InboxFilter { all, doctors, patients, consults }

enum InboxThreadKind {
  doctor,
  patient,
  consult,
  caseNote,
  support,
  admin,
}

class InboxThreadFake {
  final String id;
  final String title;
  final String subtitle;
  final String preview;
  final String timeLabel;
  final String initials;
  final InboxThreadKind kind;
  final int unreadCount;
  final bool isOnline;
  final bool isUrgent;
  final bool isVerified;
  final bool isPriority;
  final bool isAdminBadge;
  final bool showReadReceipt;
  final InboxFilter filter;

  const InboxThreadFake({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.preview,
    required this.timeLabel,
    required this.initials,
    required this.kind,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isUrgent = false,
    this.isVerified = false,
    this.isPriority = false,
    this.isAdminBadge = false,
    this.showReadReceipt = false,
    required this.filter,
  });
}

class InboxFakeData {
  InboxFakeData._();

  static const List<InboxThreadFake> threads = [
    InboxThreadFake(
      id: '1',
      title: 'Dr. Mostafa Abdelkhalek',
      subtitle: 'Nephrology · Mansoura',
      preview: 'Sharing the AKI protocol we disc...',
      timeLabel: '2m',
      initials: 'MA',
      kind: InboxThreadKind.doctor,
      unreadCount: 2,
      isOnline: true,
      isVerified: true,
      isPriority: true,
      filter: InboxFilter.doctors,
    ),
    InboxThreadFake(
      id: '2',
      title: 'Case · Sayed Mahmoud',
      subtitle: 'Patient case · ICU',
      preview: 'Labs updated — potassium risin...',
      timeLabel: '18m',
      initials: 'SM',
      kind: InboxThreadKind.caseNote,
      unreadCount: 1,
      isUrgent: true,
      isPriority: true,
      filter: InboxFilter.patients,
    ),
    InboxThreadFake(
      id: '3',
      title: 'Dr. Mohamed Shaaban',
      subtitle: 'Consultation request',
      preview: 'Can you take a quick look at th...',
      timeLabel: '1h',
      initials: 'MS',
      kind: InboxThreadKind.consult,
      unreadCount: 1,
      isOnline: true,
      isPriority: true,
      filter: InboxFilter.consults,
    ),
    InboxThreadFake(
      id: '4',
      title: 'Dr. Sara Elhosary',
      subtitle: 'Nephrology · Cairo',
      preview: "Let's adjust the dialysis schedule...",
      timeLabel: 'Yesterday',
      initials: 'SE',
      kind: InboxThreadKind.doctor,
      isVerified: true,
      showReadReceipt: true,
      filter: InboxFilter.doctors,
    ),
    InboxThreadFake(
      id: '5',
      title: 'Hoda Fathy',
      subtitle: 'Patient · Follow-up',
      preview: 'Thank you doctor, feeling better...',
      timeLabel: 'Yesterday',
      initials: 'HF',
      kind: InboxThreadKind.patient,
      showReadReceipt: true,
      filter: InboxFilter.patients,
    ),
    InboxThreadFake(
      id: '6',
      title: 'EGYAKIN Admin',
      subtitle: 'Announcements',
      preview: 'New: GFR calculator now supports...',
      timeLabel: '2d',
      initials: 'AD',
      kind: InboxThreadKind.admin,
      isAdminBadge: true,
      showReadReceipt: true,
      filter: InboxFilter.all,
    ),
    InboxThreadFake(
      id: '7',
      title: 'Case #841 · Consultation',
      subtitle: 'Nader Elzeftawy · eGFR 22',
      preview: "You: Agreed, let's start ACE inhibit...",
      timeLabel: '3d',
      initials: 'NC',
      kind: InboxThreadKind.caseNote,
      showReadReceipt: true,
      filter: InboxFilter.consults,
    ),
    InboxThreadFake(
      id: '8',
      title: 'Dr. Mariam Gamal',
      subtitle: 'Nephrology · SMH',
      preview: "Can you review Eid's latest potass...",
      timeLabel: '4d',
      initials: 'MG',
      kind: InboxThreadKind.doctor,
      isOnline: true,
      showReadReceipt: true,
      filter: InboxFilter.doctors,
    ),
  ];

  static List<InboxThreadFake> byFilter(InboxFilter filter) {
    if (filter == InboxFilter.all) return threads;
    return threads.where((t) {
      if (filter == InboxFilter.doctors) {
        return t.filter == InboxFilter.doctors;
      }
      if (filter == InboxFilter.patients) {
        return t.filter == InboxFilter.patients ||
            (t.kind == InboxThreadKind.caseNote &&
                t.filter == InboxFilter.patients);
      }
      if (filter == InboxFilter.consults) {
        return t.filter == InboxFilter.consults ||
            t.kind == InboxThreadKind.consult;
      }
      return true;
    }).toList();
  }

  static int countFor(InboxFilter filter) {
    if (filter == InboxFilter.all) return threads.length;
    return byFilter(filter).length;
  }
}
