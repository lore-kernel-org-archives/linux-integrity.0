Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B1F3B6C0E
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308415; cv=none; b=lGLyLYSchnjwzA3W4Sb+HNJWYeu6jpKJ5lgoazBXT3MEEdQ6l2pXeS9GYi9kAzSDckIaTXmpP39+C0bhBce5Otkkj3AgxJpuUn78bBgUPgQ/Y0InRSWMI8BOj2qiAChX+W1Zifb/BRKdc24RXoC1lvCKdscZ0dLN0eXhQrubrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308415; c=relaxed/simple;
	bh=qTfDTnOtLeJw9GRotW2DIhhtY+aCFHHrj7Y5nloc6uI=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=SV28PdeJElbHrL7kE1+hWBMSd0ZXh2/ZQ3llXDZudg545F91NUrN83QNJApnNBqaYtBgcDryW2CLKiIg3gIMQZVvPIZ8RI7FPOOmbABtS5zRKWmc4zgeKCBsUaq+eolcFsYb9yTSQo9JJnDtlMwYGo5uGqpJNLm9PqG7BqP/F3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=revbridgepartners.com; spf=pass smtp.mailfrom=revbridgepartners.com; dkim=pass (2048-bit key) header.d=revbridgepartners.com header.i=@revbridgepartners.com header.b=r7yRf1Jb; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=revbridgepartners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=revbridgepartners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=revbridgepartners.com header.i=@revbridgepartners.com header.b="r7yRf1Jb"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8de7bfa323bso8968426d6.1
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2026 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=revbridgepartners.com; s=google; t=1782308413; x=1782913213; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qTfDTnOtLeJw9GRotW2DIhhtY+aCFHHrj7Y5nloc6uI=;
        b=r7yRf1JbRbFUIgN0GHBSlKR8gLQkVE+S0cTr4t/8H1BSBiI1+pCDjn75GVG8zMNIQc
         V209h03fu8l0h6SQFxR11R6BB2c9scXvR25MUjTO1ftpX+6rvfBQNeQ2+ry8ySaqkiYJ
         4Xf/sHlRVAdkOERAfg72wyEqQ/48neO9VQR3zEmNSI738jenFxCVAgIO/EvdRSAuLLOV
         k5NgGCahiG+MF+MMRud6seFJHVirPgC6r+rqSj/Y1FRNz7EiqzZYLwqOjrtUHKw32d2w
         fHMh8M12tJrR6A27E4j/o4TE7RtClKnU5Yhu81MISCTMBp2vuqE6vaeEiWJldwpVOsw2
         ObiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308413; x=1782913213;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTfDTnOtLeJw9GRotW2DIhhtY+aCFHHrj7Y5nloc6uI=;
        b=RdI60lua8+JHgcycI2QUeyBRFpP+SRgy8pP4Z7ckWPfPXJqDEojBgcetVejpR3yDjl
         fs3nzgeyiK1Ml18bkU6TpDRWqvSG8VyPu0Fda9mf3UMPH+a1B3HGyet1UMJg41mXWrLK
         0tQYgddLtLaBaDWDbZ+/ORY1eTHi5nvGWmIQuDkV8fbRbHM5PbihneK5LXyuY9r+zvZP
         9FJIppS2N+R1WFimCCZFgApL1RFU2Yfx+ENMtvHQCjw/k92Eb6fens1Qi+/1H4Fx05ov
         10AKoZ8pvmjTlbfp8kjHeUYi0rszcaEa7CMxExrI501/TpRmD+exiREFJmAsiYhXWtWg
         b64w==
X-Gm-Message-State: AOJu0Yx9hjfYZkrOT68b1ALJHoOtLK9AvEOtCjxoKzm3GiXd0zJXZ9Qv
	5vVgczpZFEZiwy7Ep3wUNJ/lezv+wPbczlKh7vS7j09zBcK8Q2RF5U0MuS4WP8YbUEMaJT1L083
	u5JBTOk7z
X-Gm-Gg: AfdE7cn9cmy2Ec9Bspu3QEVOmril8aCCPeIDSIncw1f/ySadqEPmzt7tyZhb7MAgkSG
	YYeHtQLk8p7C9CPmy/xOseqy5smLydz4f77XpU94eqk/xdYa+jwdn6WEM3V+xdTM39ODaYAIVDX
	0ziB6r/F520JvmXjtFeL5upaM6fjY5qhop9W9XreXXKnv1ffxPyIsEWUCYgW+Z0DAct0IZVUvV2
	kVoj/lLOGRRzd/ibgAy8nNp7GdbzPQREi2ts8Jw2zOIt7jXPz3FKAu4CCH037B2DL1xa+T5ouU/
	XjVImp5LGt+lhJqLNw25YfHEKYFbsSY+bUSkRnke/gKY7BHWxRAT2gpbGQTyteXkPWsuslTcXEG
	xYsY1IMa07zpWgt9dfY9QD3/kX7ckUsP4ddaEfr1bxPsg6XMdEhjt+2UlC/sw7fhlT0HQlo/Vmy
	/TcBd2bl4JwVaj00gPmu21/0pWT76c12qhUTzsUtmvDyHfgGOa8uzmYms4yzhgDNJLVqLAFNfe1
	W8YU8/zTNNWWo0K0UhGdLlbhfbK8K+D3pXePJhnmA==
X-Received: by 2002:a05:620a:1721:b0:915:675d:a2d with SMTP id af79cd13be357-92784af641fmr545944785a.51.1782308413332;
        Wed, 24 Jun 2026 06:40:13 -0700 (PDT)
Received: from 019ef9dc-1add-7a21-9e9e-da3064f924da.local (ec2-98-81-26-21.compute-1.amazonaws.com. [98.81.26.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c31b4sm563017485a.23.2026.06.24.06.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:40:12 -0700 (PDT)
Message-ID: <019ef9dc-1add-7a21-9e9e-da3064f924da@revbridgepartners.com>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/019ef9dc-1add-7a21-9e9e-da3064f924da
From: Eric Young <e.young@revbridgepartners.com>
To: linux-integrity@vger.kernel.org
Subject: Kernsec sales
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 13:40:12 +0000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi,

I noticed your focus on the Linux kernel security subsystem and the =
resources you provide for developers and users.

Managing detailed =
technical information and supporting user communication can be time =
consuming without the right tools.

We have helped teams automate client =
interactions and scheduling in complex technical environments without =
adding extra resources.

Would you be open to a brief conversation to =
explore if this could help streamline your community engagement?=C2=A0


Eric
422 Richards St, Suite 170. Vancouver, BC V6B 2Z4
P.S. Please let me know if you don't want to hear from me =
again
