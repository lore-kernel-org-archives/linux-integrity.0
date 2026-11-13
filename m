Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590955;
	b=mggQrN5t4t535Z1y2S4tQgmmdNrKbiHOP5fIJJCZ5u8Gf20HO1ada08kEcQjCcyP1g4C
	 8zE8Iwjh4od5HTxHK1ke7P1ZM5wHZR/5R+gcbQXA/0F9/uChEm4g1aKYTHJhU/GVOLWLY
	 9JAgn2GwDHw6nyxV905kwHECp1cyf7DoO1qLqKD7ri5YEXANc+zQ77u78QpiIbJe00Ch1
	 8DmEXoR/90JtVYp1pUsqi5lpzL1cOvd5Of/v4/sWNWrWR/BF54sot3qfmuHPTYVNdPY5k
	 3Ta4CU2K90d/cwyu2PEpXOy5o5rsKwDyy3V2vy4RzZrm2TwxR6NdvOwSPpvpFoa9/mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590955;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oqO07NhLTdzxWqunxJseQ1MRQIDCj/OeQS+fIjl94C4=;
	b=Zsvdf3G1d2G022S1WE8wpsxaeLT/Yz/ws7hxiRU9RKu2eXKj3pwLUzylrMxEenn7IfSA
	 hqi7rVQMq/2lRsh6PEDDGAmjiI0dTFH4DSkVUb1W6o9XeQRU14+vkeEUOppalccqpKfJf
	 oGaZSIpFM6/ULtvptluIf+5HAPQ/IrffnkN1drcXPn4ETgLWm0wDN2BLnMOD7Ni6pfSDx
	 WFp80U+kOwvaCWS7j8J8GFbZN9fqLjHdD1TC+7thIYaNQ4BWDy7CmGJKCyhV75dgpiRNa
	 SWJEVVhqrOTME7qsvvmhrPw1zQaBAY7caN5kAUMLDhrLlq+AnK3qbp0Sebzl30UMdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZF3HrjXF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKptEdwi;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4A606F70C
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 17:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C4A606F70C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZF3HrjXF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKptEdwi
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFjPdA782538
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 17:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oqO07NhLTdzxWqunxJseQ1MR
	QIDCj/OeQS+fIjl94C4=; b=ZF3HrjXFxvBahlFkLVOo5iOLaa7fRxyb1e4ITp+W
	uQ9ugQkncZxoT5DeIa3KY7D9ZfT1fF3avUkjNpDacB4at6BsMJ4efxLuo08aPCYP
	zDx+wLjb47rchtJv/34lTqkg2rCQTixrWezSm49ORtnG81lBS0QcA7qjHA6P1XVk
	TxkCTmk4vAR8T5AMebS2OBqTVMNH0bHarstPW+MEHjdIyTdYDXh5UIk/A+ES4BZX
	diehGKA4gpPmQJ4VXV3xZ1hRd0ayrw7Ut+b+9KPka/9IZfViQpoiJLj9dcLoMd4s
	IvZJp/eN5SjXgTIlhIKlnhKEKcZytR0WAqibAvhly+a40w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37jjjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 17:29:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f5844cb60so250904585a.0
        for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2026 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794590953; x=1795195753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqO07NhLTdzxWqunxJseQ1MRQIDCj/OeQS+fIjl94C4=;
        b=FKptEdwic02kZaz2nm5G2HCJX1fuMyNxYsZYR4e6tJEeZ84A63LiorKhIefUXS4aa+
         7d6GqK3jCbKkx9Br+VXjXk/zSGiu3mBlWdIi7Az0773LqZvdir3ZnX8X2ti0H5c+7yto
         vsK8ktunJm+i4KkCPimA/inxX3hjCO8ZOP7NWuLejpxvxTyDRIDHWcFrrAGARgpzD9cP
         h3QWwKdrcuwvOxHOACOLGOr2zYb8PpEK+ssd282NDsHxG8rQ5tpOmCCwil7pCrGJWPZH
         o65/3qCKE69Di0+pF7HdPtKaW3IZ9mDlyhj0sAaJ+g9Zf8ou/wDzM0RGTm5qspz7DZhD
         p6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590953; x=1795195753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqO07NhLTdzxWqunxJseQ1MRQIDCj/OeQS+fIjl94C4=;
        b=0ZwDxHMnopBUeLx8d5moAO1hYcKsXRgDupF3tCwOEztSjfVbxad7O2zlaDH51vrg2J
         79ivgT7lo9dykc7A3oiIK/pNgmchnJCx9Xf6GujGUPYxFDoSxgo/htJtlbkPNuwYeU19
         mCiLJQy9cDV+Ugxl6zXw1H0joC7hFhlU+GhF3r9IJ0bNahn5U2m9buf3tslY2qDuz1ZH
         yb/b0E8dXrJVTIgko0MTkd/owrkF2CTyBC54HDE7VjmYVv590DeldfR2sHlxbfo8hzYo
         hSZjJcy/t3pCEFHIlgVyOLTDMMqteZ3eEMzFupIr46ciHyG49Q1BEUDITGPZVu9jX4Tx
         mstQ==
X-Forwarded-Encrypted: i=1; AL+hErFdEEoDmOV42OQUeY/0Y2VzULKp83CDFfqB+hzBN+XaPpCBm06l+vaka2CZ+zSog8d9WEfuItM+shxutyLk8WM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mRv7XUlbvx00vYpLGu08GUsFYgCzPGyb7hhuSxd86gQ0gDITX
	SjhItjMo5JTF3US1Fw2aj9r4GSECtQnqNiWlujIOflqn7G9rjfDBuHxNnyYjSj5le9MzsPcNQsT
	CZWBdP5f5QrIBAqMocuTwLhJCOwtpUpqmtqpFWQ4NVkv0aAjiPW+FzxBeJ64WJg4NDj3mZ7c=
X-Gm-Gg: AYBFou1ld7dIlo5FaKv7UaLz7dh3DkuRQUCd6OBTr4imrnzpzqMj10r4at8D8XJJFCa
	Lp8ZjgyFKrpzFXFW3u/kRLhEDzxx1u0cN2bQJTRMgHz+YaoojmRzk20FNouCKdu4ndX26jguD08
	rnkXMxoLpltZoPFlKNm78HfUwixmQ7dBP0divCikVTMguCbgKf3fSLKjVj5BYxYeEdq8mOaMpK+
	XyFaFjJYE703AUgVvponceqebMSI+ZLzatHY1ZSrlIgVImireXIOXQSMNlaMb0/0BSJTE4lIJi4
	c0z9xQCqNUWEfMllMEG9Gzdw3dsjdmLvWmQ1qH2TS+H+fF2ycwYaUA5fup61+P705UMaR1hJN4l
	GPyFhEfA714bhSRr1pHScvxww4lOrvCaNMU6SAENyoR/AlqVEswMZpYYaU6Z72Q/jldKpf40qD4
	HBZA==
X-Received: by 2002:a05:620a:29c5:b0:93f:2e81:2217 with SMTP id af79cd13be357-94933140dd8mr1066097185a.36.1794590952963;
        Fri, 13 Nov 2026 09:29:12 -0800 (PST)
X-Received: by 2002:a05:620a:29c5:b0:93f:2e81:2217 with SMTP id af79cd13be357-94933140dd8mr1066090185a.36.1794590952162;
        Fri, 13 Nov 2026 09:29:12 -0800 (PST)
Received: from trex (50.red-81-37-172.dynamicip.rima-tde.net. [81.37.172.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1968sm5993662f8f.10.2026.11.13.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:29:11 -0800 (PST)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 13 Nov 2026 18:29:10 +0100
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tpm: OP-TEE transport core for discrete and
 firmware TPMs
Message-ID: <avdI5vZCobTmpIuM@trex>
References: <20261111215940.3503287-1-jorge.ramirez@oss.qualcomm.com>
 <avciKM_pGW6hs_so@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avciKM_pGW6hs_so@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2OSBTYWx0ZWRfX7Llb+yq2WeoH
 jjcJyQD379+Z/NaZ0Wxw0FeTm2pt9TX+zpa64a/xf+YZGRc9LCDSGrCSkBoIn7s4IOcTfL7Gm2h
 h5diEwygGZ09fjvTSti/6h5kcW/1SOM=
X-Proofpoint-ORIG-GUID: _jGihiqabX4BltuCENkjze2Kb8saCqZm
X-Proofpoint-GUID: _jGihiqabX4BltuCENkjze2Kb8saCqZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2OSBTYWx0ZWRfX6AXy8pH4WGbO
 aDNHMbysNgWzxE8EYptWCz7vKi3DX76eiCCrFRUP6roa2Jq4Qx/RRkbLl71rYUs6oPuJZ4gvqSE
 o2M0zack0ad9hh4Rudj0fhtyOtbYAMqdkWTQlab2PaKAQZp49sXkqGHt+0lntsdyXRaTU9fXNL4
 kFzskY3l78k7uFyF9gIGFkfs2angw1n5XAIebqIwN4r9hta5ZhUb9H93UODdV0qnYDJcoeqXxWP
 XTsOlekT0NxJvJ/U89v5UGyQxI0lJy3k4uBOh0/TIcow/+zHa3lcTcCPLn/q8LRaMkeLJxyZhx6
 +BsDWcLBlCk9T2jaFAT5vCF9G2ThzbK12ha9K4R5FYElieiRgSXq6t2Pm6d9L587EaIrPj/Ypvn
 Q+gQ+J9G+wE7LQHjv3mAHx4hfT5LRjWlOxL5GJPB80Y0vPRx/M66aMBIp0ZUWCFxR1sVp3Vc1CL
 RNDNauEo3Hhn1m+PkGw==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af748e9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=VbO86HPdXvN82gCvB8O6pw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=McN5tr3TAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FuZrFBbP_L4GtrPzmhMA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=OiMWn5MEmObRqTLTTlUg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130069

On 13/11/26 16:43:52, Jarkko Sakkinen wrote:
> On Wed, Nov 11, 2026 at 10:59:33PM +0100, Jorge Ramirez-Ortiz wrote:
> > This adds a driver for a discrete TPM that OP-TEE owns and the normal
> > world cannot reach directly, and factors the shared OP-TEE TEE transport
> > into a small core so the existing fTPM driver uses it too:
> > 
> >   - a transport core shared by the OP-TEE TPM front-ends;
> >   - a new discrete TPM front-end;
> >   - the fTPM driver converted onto the core, keeping its name, its
> >     platform/OF binding and its shutdown path.
> > 
> > Patch 1 is the feature; patch 2 is the fTPM conversion that justifies the
> > core. Both front-ends were exercised on the Qualcomm Lemans EVK over the
> > shared core: the discrete ST33 TPM (patch 1) and the MS-TPM-20 firmware
> > TPM TA (patch 2), each presenting a working /dev/tpm0 (tpm2_getrandom,
> > PCR read). The fTPM TA is the same MS-TPM-20 reference the existing
> > tpm_ftpm_tee platforms use.
> > 
> > This is the normal-world half. The secure-world OP-TEE support it binds
> > to -- the in-core TPM2 SPI (TIS) driver and the mediator pseudo TA that
> > relays commands to it -- is under review separately:
> > 
> >   OP-TEE support: https://github.com/OP-TEE/optee_os/pull/8155
> >   locality 4:     https://github.com/OP-TEE/optee_os/issues/8160
> >                   (design follow-up: the secure world policing
> >                   normal-world locality access to the shared chip)
> > 
> > Build and test it on the Qualcomm Lemans EVK (a discrete ST33 TPM on
> > SPI, owned by OP-TEE):
> > 
> >   https://qualcomm-linux.github.io/qcom-buildroot/lemans/quick-start.html
> > 
> > v1: https://lore.kernel.org/linux-integrity/20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com/
> > v2: https://lore.kernel.org/linux-integrity/20261110141923.3100770-1-jorge.ramirez@oss.qualcomm.com/
> > 
> > Changes since v2:
> >  - tpm_optee_dtpm: give the discrete-TPM front-end a .shutdown callback so
> >    it releases its TEE session and dynamic shared memory on shutdown/kexec,
> >    as the fTPM front-end already did; without it the session and the
> >    normal-world pages stayed registered in OP-TEE across a kexec, which can
> >    stop the next kernel opening a session to the chip.
> >  - move the shared tpm_optee_shutdown() helper into the core patch so that
> >    patch builds on its own; the dTPM front-end no longer forward-references
> >    a symbol that was added in patch 2.
> > 
> > Changes since v1:
> >  - split the shared TEE transport into a core; the discrete chip is now a
> >    thin front-end, the tpm_tis_core-style solution that was asked for.
> >  - convert the fTPM driver onto the same core instead of duplicating it.
> >  - use an optee-prefixed name for the new modules; the fTPM driver keeps
> >    its name, no module rename.
> >  - rewrite the commit message with a plain description of the components
> >    and the rationale for a separate front-end.
> >  - drop the explicit zeroing in favour of initialisers, and reword the
> >    module description.
> > 
> > Jorge Ramirez-Ortiz (2):
> >   tpm: add OP-TEE transport core and a discrete TPM driver
> >   tpm_ftpm_tee: use the tpm_optee transport core
> > 
> >  MAINTAINERS                       |   8 +
> >  drivers/char/tpm/Kconfig          |  28 +++
> >  drivers/char/tpm/Makefile         |   2 +
> >  drivers/char/tpm/tpm_ftpm_tee.c   | 295 ++----------------------------
> >  drivers/char/tpm/tpm_ftpm_tee.h   |  35 ----
> >  drivers/char/tpm/tpm_optee.c      | 253 +++++++++++++++++++++++++
> >  drivers/char/tpm/tpm_optee.h      |  32 ++++
> >  drivers/char/tpm/tpm_optee_dtpm.c |  73 ++++++++
> >  8 files changed, 414 insertions(+), 312 deletions(-)
> >  delete mode 100644 drivers/char/tpm/tpm_ftpm_tee.h
> >  create mode 100644 drivers/char/tpm/tpm_optee.c
> >  create mode 100644 drivers/char/tpm/tpm_optee.h
> >  create mode 100644 drivers/char/tpm/tpm_optee_dtpm.c
> > 
> > 
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > -- 
> > 2.55.0
> > 
> 
> I applied but had to fix some merge conflicts so check up my tree.
> 
> Br, Jarkko

thanks and sorry about it.

I had a look to your tree and it looks good. But I think we could
perhaps add the following to the new file (see the patch below)

Not sure how to do it thought- shall I send it standalone?

 drivers/char/tpm/tpm_optee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_optee.c b/drivers/char/tpm/tpm_optee.c
index e2223242327e..3c17de1306a1 100644
--- a/drivers/char/tpm/tpm_optee.c
+++ b/drivers/char/tpm/tpm_optee.c
@@ -166,7 +166,7 @@ int tpm_optee_probe(struct device *dev, const struct tpm_optee_config *cfg)
        struct tpm_chip *chip;
        int rc;
 
-       pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
+       pvt_data = devm_kzalloc_obj(dev, struct tpm_optee_private);
        if (!pvt_data)
                return -ENOMEM;
 
-- 
