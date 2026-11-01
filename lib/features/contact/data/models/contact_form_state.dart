enum FormSubmissionStatus { initial, submitting, success, error }

class ContactFormState {
  final String name;
  final String email;
  final String subject;
  final String message;
  final FormSubmissionStatus status;
  final String? errorMessage;

  const ContactFormState({
    this.name = '',
    this.email = '',
    this.subject = '',
    this.message = '',
    this.status = FormSubmissionStatus.initial,
    this.errorMessage,
  });

  ContactFormState copyWith({
    String? name,
    String? email,
    String? subject,
    String? message,
    FormSubmissionStatus? status,
    String? errorMessage,
  }) {
    return ContactFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
