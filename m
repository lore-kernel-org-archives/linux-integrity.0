Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795760;
	b=dB8NvT+9Sn8F83ox8QTflFFoospiH0xs9pNRmcpsMn/D4qyOzOY7y5w8My2xkMp5TnNI
	 wGnAORBotIXEGDHf3/NyLu0RpiBMQ4uPo6wMNwWOZQlM0ILen3NB8geXBWAQpu5oe8pxe
	 xwCqyQKisJWDzR6teqDYl49FjURejcyhQ9DP+3W0sbw107krr2LfyJ6EgwWhP5Ku2KB+0
	 dw2A5Qiy/ixTjScDLoVN3mmj17yK2IGERC200xKgeS30Yocr41A7zmq95uC2BwxMRIOr+
	 P/vxMZLKdsU2kVWBC9FuHzFA8BIyoxAY3s12FZtA26RHfH6fQAeIFJIjaZuy5rdVz2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795760;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=NXv6ov7j2JUiAHmIY3+LWvm5ECdzsKbptyp8TPWwrdU=;
	b=4btVC/8oi2YeROBtBtfF1wZqU/nVNNxV8zb3FFtkPx1s6X2U5DUSamieHPFUufbNwYod
	 byDDQDzS/Wp5tHj74u3TNxLAQYBVYAuF4ZW/f8Bl7Ns8UKDMWFBhE1LTubBfxanmB5dgK
	 xeKbvwxle/y/XLDtygAawr4irALftJW3mxCs89WNVW0VD5QjEHPgdq48zNYZWvI6ltIB6
	 Joa/yNFT5A5xvr/dCh7oXxIrUVOkPttO1XwDGKzuqjYInDx12tEQnEXQKo53clGbJpbP9
	 VRAA+dKnC4q9B9G80ox1gIT9PD8f7INI8qSyrTUKktY6l5kZlP5CBYJzdDA6/+QX5tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yOs1OJlX;
	arc=none smtp.remote-ip=203.205.221.190
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9C606A332;
	Fri, 27 Nov 2026 16:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E9C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yOs1OJlX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795795750; bh=NXv6ov7j2JUiAHmIY3+LWvm5ECdzsKbptyp8TPWwrdU=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=yOs1OJlXen1ssNgoXdNsu/+VN3Iqx9iBSJ9PIJmcYmmZxPdmfsYX0u63pBPWbx67Y
	 lciprx5gpKQCaKiBD9QhEr3yzq8LiarSWQraRRjSzjSFu9jFHR3ha3Rj++1tSR9y/f
	 IeQ86qpsT5uOv6I7oMwnAb0rafdyVL6PnY/JUDYY=
Received: from [172.16.4.32] ([2408:8221:620:8610:f181:7ac4:be13:908a])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 24693453; Sat, 28 Nov 2026 00:09:06 +0800
X-QQ-mid: xmsmtpt1795795746tsbxqqkzk
Message-ID: <tencent_2C2BD6A76160698ABD6C98DFEA45B7D72006@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAYZJ1yPXDADI7prF8jlUSyveBgXjrUTk2icDAbvztgHmHnMZ6av
	 mrY/6hjo5Bh55ZlWg1yNth7OFxT/79yezicuQX6KIDJDfYoiRc1zrjBkVGc2W4k8626SjpRrQnpU
	 nxTyQA0Bo+SrNM7JjpMzBRhORhFXM7KLmi4EVgzyey65z9FSu8GQkag3XxYXoIaa5DL+cQdJrgOh
	 0fnvol1RD52Cacgy8/AR9mJwo+Ye+31dpoeSkOgwTHpx8+d5uD/tzaU365REJtDV0XRMEIrFFJzR
	 diHflhahm6cyGtCZYNbz4Wn3b+nXNI6ucMK97RLgt0KvqMtr55tQZPakvVTOYzBxgpYFMpc12/F9
	 yd0K7yj4gypE2kVlIwtrbEa3v9wY4FstE8ny480hmhSevsGF0RIk2gkXiM5IeNt97c/hi1BsM+53
	 PmlwTLr19szKKT7IVknKlvpjh7PCUEsawdTvbD9l+uEcZ+syQUViOpgAcU9eFyHVs1uxDOXOLCrz
	 wLqIrx5d2jpZlR+TRCHPTsbpTv4d8ZZBaHCu7VWGfbJUc06A2IpCB198Wu388cXBEQmzPPX2Cwjl
	 n7CvNo5fJRKosugMti+sWFexUFDcqM7eeCc6Q5dRIvGSDlylEo6wDivDG9XhYgtzOyd151xzG1y3
	 w6TZzrAaICIT+aeiUwAfgNYyFuMFeE90gcSnPJVpOgRGYkkq1kheexPTWdAwBwWEQjgvZBPIvlVl
	 sxBAbYaxjH79g6FPYd1Ad1xrINQKrC0TpuKufR0blUduRdtJ2ab7fGmITE5beNbOkN0I2Lm/83hL
	 M4m2Ex/h1zbDw4mFPTmUnzk2GCU/BXIlmcO0MJXVn+dY2wYaHPwfr6ZmN08FRC42zpwiq0rZeSFV
	 6E9VBYu1zDng5d/amPNaZnCVBKcMnAqr/Ka4YackX/94455MdFCoAI6XkC8vYrRAFULp0DyEZEW2
	 z+EvETM9foJJ9i+Y4YCb5RwXTde0PDIHecJYi5wJ6rFWUHiALqzLz6Tg8sGPCBTTwpo/JItGW7+W
	 NnscuyaQYjvbRrFpfOQFuhKkeRD5jrUHbbMucEUM9Y/9hKu3XRbT/XVzCFdD80ptwFnB+Cg8iZ8k
	 WjQT+YJtEoLL7vrx7JNGV4LQ1l8w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Chenshuo Zhang <abc0eichs@qq.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] lib/asn1_encoder: fix encoding of zero OID components
Date: Fri, 27 Nov 2026 23:59:47 +0800
X-OQ-MSGID: <179579518734.36512.17026717360352959442@qq.com>
In-Reply-To: <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
References: <tencent_AFE15D698FFD4F18E16A6EF7CDA002D69806@qq.com>
 <20261123220311.9ee34b6c33545185d41d09ce@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

> So for now I'll rewrite this as From:me and Reported-by:zzz.

Thanks, Andrew. Please use Chenshuo Zhang for the patch attribution.

I tested James's suggestion to share the final-octet path for
single-octet subidentifiers. The UML KUnit tests and the x86_64 W=1
build passed. Would you prefer a v2 to replace the queued patch,
or a follow-up patch?

Signed-off-by: Chenshuo Zhang <abc0eichs@qq.com>

