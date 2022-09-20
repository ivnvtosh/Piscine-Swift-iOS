//
//  ViewController.swift
//  Day-07
//
//  Created by Anton Ivanov on 21.08.2022.
//

import UIKit
import RecastAI
import ForecastIO
import CoreLocation
import JSQMessagesViewController


typealias Message = [JSQMessage]
typealias Messages = Message

struct Human {
	let id: String
	let name: String
}

typealias People = [Human]

class ViewController: JSQMessagesViewController {

	private	var people: People = [
		Human(id: "0", name: "SIRI"),
		Human(id: "1", name: "ccamie")
	]

	private var messages: Messages = {
		var messages = Messages()

		let message = JSQMessage(
			senderId: "0",
			displayName: "SIRI",
			text: "Hi, I'm SIRI! Enter city"
		)

		guard let message = message else {
			return messages
		}

		messages.append(message)

		return messages
	}()

	override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
		return NSAttributedString(string: messages[indexPath.row].senderDisplayName)
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
		return 16
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
		return nil
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource? {
		let background = JSQMessagesBubbleImageFactory()!

		if messages[indexPath.row].senderId == people.first?.id {
			return background.incomingMessagesBubbleImage(with: .tintColor)
		}

		return background.outgoingMessagesBubbleImage(with: .blue)
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
	}

	override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
		return messages[indexPath.row]
	}

	override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
		let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)

		messages.append(message!)
		finishSendingMessage()
		bot.textRequest(
			text,
			successHandler: successHandler,
			failureHandle: failureHandle
		)
	}

	override func senderId() -> String {
		return people.last!.id
	}

	override func senderDisplayName() -> String {
		return people.last!.name
	}






	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.addGestureRecognizer(tapGestureRecognizer)

		self.view.backgroundColor = .systemBackground
//		self.stackView.addSubview(self.label)
//		self.view.addSubview(self.viewBack)
//		self.view.addSubview(self.stackView)

//		self.stackView.addArrangedSubview(self.viewBackTextField)
//		self.viewBackTextField.addSubview(self.textField)
//		self.stackView.addArrangedSubview(self.viewBackButton)
//		self.viewBackButton.addSubview(self.button)

//		setupConstraints()
	}

	private func updateData(location: CLLocationCoordinate2D) {
		darkSky.getForecast(location: location) { result in
			DispatchQueue.main.async {
				switch result {
				case .success((let forecast, _)):
					let message = JSQMessage(
						senderId: self.people.first!.id,
						displayName: self.people.first!.name,
						text: "The wether is \(forecast.currently!.summary!) \(forecast.currently!.temperature!) C")
					self.messages.append(message!)
					self.finishSendingMessage()
//					self.label.text = forecast.currently?.summary?.description ?? "Error"
				case .failure:
					let message = JSQMessage(
						senderId: self.people.first!.id,
						displayName: self.people.first!.name,
						text: "Error")

					self.messages.append(message!)
					self.finishSendingMessage()
//					self.label.text = "Error"
				}
			}
		}
	}

//	MARK: - DARK SKY
	private var darkSky: DarkSkyClient = {
		let darkSky = DarkSkyClient(apiKey: "2ac4b9753bab9108db8df8f8a3705537")

		darkSky.units = .si
		darkSky.language = .english

		return darkSky
	}()

//	MARK: - BOT
	private var bot: RecastAIClient = {
		let bot = RecastAIClient(
			token: "c80f802ac6dd241654df237385b351b5",
			language: "en"
		)

		return bot
	}()

//	MARK: - LABEL
	private lazy var label: UILabel = {
		let label = UILabel()

		label.text = """
			Hi, I'm SIRI!
			Enter city
			"""
		label.numberOfLines = 0

		return label
	}()

//	MARK: - BOTTOM PANEL
	private lazy var textField: UITextField = {
		let textField = UITextField()

		textField.placeholder = "Enter city"

		return textField
	}()

	private lazy var button: UIButton = {
		let button = UIButton()

		let image = UIImage(systemName: "paperplane")
		button.setBackgroundImage(image, for: .normal)
		button.tintColor = .secondaryLabel
		button.addTarget(
			self,
			action: #selector(buttonAction(sender:)),
			for: .touchUpInside
		)

		return button
	}()

//	MARK: - BUTTON ACTION
	@objc private func buttonAction(sender: UIButton) {
		guard let text = self.textField.text else {
			return
		}

		if text.isEmpty == true {
			return
		}

		if justSpaces(string: text) == true {
			return
		}

		bot.textRequest(
			text,
			successHandler: successHandler,
			failureHandle: failureHandle
		)
	}

	private func justSpaces(string: String) -> Bool {
		for character in string {
			if character != " " {
				return false
			}
		}

		return true
	}

	private func successHandler(response: Response) {
		guard let locations = response.all(entity: "location") else {
//			self.label.text = "Enter a valid city"
			let message = JSQMessage(
				senderId: self.people.first!.id,
				displayName: self.people.first!.name,
				text: "Error")

			self.messages.append(message!)
			self.finishSendingMessage()
			return
		}

		guard let latitude = locations[0]["lat"]?.doubleValue,
			  let longitude = locations[0]["lng"]?.doubleValue else {

//			self.label.text = "Error"
			let message = JSQMessage(
				senderId: self.people.first!.id,
				displayName: self.people.first!.name,
				text: "Error")

			self.messages.append(message!)
			self.finishSendingMessage()
			return
		}

		let location  = CLLocationCoordinate2D(
			latitude: latitude,
			longitude: longitude
		)

		updateData(location: location)
	}

	private func failureHandle(error: Error) {
//		self.label.text = "Error"
		let message = JSQMessage(
			senderId: self.people.first!.id,
			displayName: self.people.first!.name,
			text: "Error")

		self.messages.append(message!)
		self.finishSendingMessage()
	}

	private lazy var viewBack: UIView = {
		let view = UIView()

		view.backgroundColor = .systemGray4

		return view
	}()

	private lazy var viewBackTextField: UIView = {
		let view = UIView()

		view.backgroundColor = .systemGray6
		view.layer.cornerRadius = 20

		return view
	}()

	private lazy var viewBackButton: UIView = {
		let view = UIView()

		return view
	}()

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()

		stackView.axis = .horizontal

		return stackView
	}()

	private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		let gestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(tapAction(sender:))
		)

		return gestureRecognizer
	}()

	@objc private func tapAction(sender: UITapGestureRecognizer) {
		self.view.endEditing(true)
	}

//	MARK: - CONSTRAINTS
	private func setupConstraints() {
		var constraints = [NSLayoutConstraint]()

		self.label.translatesAutoresizingMaskIntoConstraints = false
		self.textField.translatesAutoresizingMaskIntoConstraints = false
		self.button.translatesAutoresizingMaskIntoConstraints = false
		self.viewBack.translatesAutoresizingMaskIntoConstraints = false
		self.stackView.translatesAutoresizingMaskIntoConstraints = false



//		MARK: - CONSTRAINTS LABEL
		constraints.append(
			self.label.topAnchor.constraint(
				equalTo: self.view.safeAreaLayoutGuide.topAnchor,
				constant: 20
			)
		)
		constraints.append(
			self.label.bottomAnchor.constraint(
				equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
				constant: -200
			)
		)
		constraints.append(
			self.label.leadingAnchor.constraint(
				equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
				constant: 20
			)
		)
		constraints.append(
			self.label.trailingAnchor.constraint(
				equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
				constant: -20
			)
		)



//		MARK: - CONSTRAINTS BOTTOM PANEL
		constraints.append(
			self.stackView.bottomAnchor.constraint(
				equalTo: self.view.keyboardLayoutGuide.topAnchor,
				constant: -10
			)
		)
		constraints.append(
			self.stackView.leadingAnchor.constraint(
				equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
				constant: 20)
		)
		constraints.append(
			self.stackView.trailingAnchor.constraint(
				equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
				constant: -20
			)
		)
		constraints.append(
			self.stackView.heightAnchor.constraint(
				equalToConstant: 40
			)
		)



		constraints.append(
			self.textField.topAnchor.constraint(
				equalTo: self.viewBackTextField.topAnchor
			)
		)
		constraints.append(
			self.textField.bottomAnchor.constraint(
				equalTo: self.viewBackTextField.bottomAnchor
			)
		)
		constraints.append(
			self.textField.leadingAnchor.constraint(
				equalTo: self.viewBackTextField.leadingAnchor,
				constant: 20
			)
		)
		constraints.append(
			self.textField.trailingAnchor.constraint(
				equalTo: self.viewBackTextField.trailingAnchor,
				constant: -20
			)
		)



		constraints.append(
			self.viewBack.bottomAnchor.constraint(
				equalTo: self.view.keyboardLayoutGuide.topAnchor,
				constant: 60
			)
		)
		constraints.append(
			self.viewBack.leadingAnchor.constraint(
				equalTo: self.view.leadingAnchor,
				constant: 0
			)
		)
		constraints.append(
			self.viewBack.trailingAnchor.constraint(
				equalTo: self.view.trailingAnchor,
				constant: 0
			)
		)
		constraints.append(
			self.viewBack.heightAnchor.constraint(
				equalToConstant: 120
			)
		)



		constraints.append(
			self.viewBackButton.widthAnchor.constraint(
				equalToConstant: 40
			)
		)



		constraints.append(
			self.button.topAnchor.constraint(
				equalTo: self.viewBackButton.topAnchor,
				constant: 6
			)
		)
		constraints.append(
			self.button.bottomAnchor.constraint(
				equalTo: self.viewBackButton.bottomAnchor,
				constant: -6
			)
		)
		constraints.append(
			self.button.leadingAnchor.constraint(
				equalTo: self.viewBackButton.leadingAnchor,
				constant: 12
			)
		)
		constraints.append(
			self.button.trailingAnchor.constraint(
				equalTo: self.viewBackButton.trailingAnchor
			)
		)



		NSLayoutConstraint.activate(constraints)
	}


}

