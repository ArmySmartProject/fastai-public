package ai.maum.biz.fastaicc.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Service
public class CustomProperties {
	@Value("${websocket.protocol}")
	String websocketProtocol;

	@Value("${websocket.ip}")
	String websocketIp;

	@Value("${websocket.port}")
	String websocketPort;

	@Value("${audio.ip}")
	String audioIp;

	@Value("${audio.port}")
	String audioPort;

	@Value("${rest.ip}")
	String restIp;

	@Value("${rest.port}")
	String restPort;

	@Value("${rest.ssl}")
	Boolean restSsl;

	@Value("${voice.ip}")
	String voiceIp;

	@Value("${voice.port}")
	String voicePort;

	@Value("${excel.form.path}")
	String excelFormPath;

	@Value("${excel.upload.path}")
	String excelUploadPath;

	@Value("${mail-info.username}")
	String mailUsername;

	@Value("${mail-info.password}")
	String mailPassword;

	@Value("${mail-info.port}")
	int mailPort;

	@Value("${mail-info.host}")
	String mailHost;

	@Value("${mail-info.Internet-address}")
	String mailAddress;

	@Value("${proxy.protocol}")
	String proxyProtocol;

	@Value("${proxy.ip}")
	String proxyIp;

	@Value("${proxy.port}")
	String proxyPort;

	@Value("${chatting.ip}")
	String chattingIp;

	@Value("${chatting.port}")
	String chattingPort;

	@Value("${obcalltotal.protocol}")
	String obcalltotalProtocol;

	@Value("${obcalltotal.ip}")
	String obcalltotalIp;

	@Value("${obcalltotal.port}")
	String obcalltotalPort;

	@Value("${domain}")
	String domain;

	@Value("${cookie.domainName}")
	String cookieDomainName;

	@Value("${autocall.is-execute}")
	Boolean autocallIsExecute;

	// TODO 이 시간으로 batch 도는 주기 조절할 수 있도록 수정 필요
	@Value("${autocall.batch-interval-time}")
	String autocallIntervalTime;

	@Value("${autocall.check-valid-url}")
	String autocallCheckValidUrl;

	@Value("${database.active}")
	String databaseActive;

	@Value("${iframe_url.simplebot}")
	String simplebotUrl;

	@Value("${iframe_url.chatbotBuilder}")
	String chatbotBuilderUrl;

	@Value("${iframe_url.voicebotBuilder}")
	String voicebotBuilderUrl;

	@Value("${api.simplebot.get_list_url}")
	String SimplebotListApi;

	@Value("${msgtalk.is-execute}")
	Boolean msgtalkIsExecute;

	@Value("${msgtalk.batch-interval-time}")
	String msgtalkIntervalTime;

	@Value("${msgtalk.check-valid-url}")
	String msgtalkCheckValidUrl;

	@Value("${site-custom}")
	String siteCustom;

	@Value("${pw-month:3}")
	int pwMonth;

	@Value("${pw-err-max:5}")
	int pwErrMax;

	@Value("${work-request.form.path}")
	String workRequestFormPath;

	@Value("${work-request.upload.path}")
	String workRequestUploadPath;
}
