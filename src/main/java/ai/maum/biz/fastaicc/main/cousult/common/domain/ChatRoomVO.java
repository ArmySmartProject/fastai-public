package ai.maum.biz.fastaicc.main.cousult.common.domain;

import lombok.Data;

@Data
public class ChatRoomVO {

	private Boolean available;
	private Boolean bot;
	private String csCategory;
	private String roomId;
	private String status;
	private String userId;
	private String sessionId;

}


