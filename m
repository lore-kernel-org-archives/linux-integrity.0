Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818240;
	b=4Cj2U4R6ZzneXzLbxMwP7csJ8tLYZ0R0K9cYkeheYSOLBoweVTy0oCpvya5YEi/Ln++y
	 4KoKlWxEaaYqP1uHCji/BgnjIngLmH4Etip8cDKcoX47Q+Cjlt2eRfjCv9tX1JCRKF9IO
	 WFsfiRAdAOQP2AHbg+ou9YCjzFpYz/ErfS4er0JTg33ZPH8JmKMQjfRYebIAdngNQnCBe
	 1DUnQnwlDB/J3HKucJySumN0mjopqI7rv6w2Wj+4SGIeuE0kpBhwtg3Mi9BzII2BDl0In
	 HQPR+SgVnWOdE2PSiepDTCOHfpNbby19sa8x2GdqGVAAIALtgEQk8tLsNjshNMK4Mhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818240;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=k0iiKTShuZ2pTGwItgfN88ty0wCxAVF1X1qAn7I9Kjs=;
	b=JhysJpVIEmM6RGw8ny0qi+2rFhJrylCf+r4IRtAOBHDfl0vj79c0Akq4MYFaANLUgqux
	 b1rkKlyo+M53HR361F8R2JMCnTAYKG5OwmhyUy3K9X7WxRdg4PMeUOsopEOv6nudeNrzx
	 SyKfDUDLphdshpZW8kkNmM68P2z43BLXSf/qUFkseD+/pU4awbjUPyoScs1tmo9a6ViRR
	 GGaYPJ2kD7C6/6BdLNE603dNEItWp0U/LxjM2CShOvn3ySKO0CMrqfhANFaZEdmOpj1wT
	 8z3ZbKjdFbktcxhGGu4YFskIWyc6abWGzB9DNBB+rlBIODgmeX8zy0fs4ZI72iM4x3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=r2jPl15D;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C66606A321;
	Fri, 27 Nov 2026 22:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C66606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=r2jPl15D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795818239; x=1827354239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0iiKTShuZ2pTGwItgfN88ty0wCxAVF1X1qAn7I9Kjs=;
  b=r2jPl15D+aEKoZtOb4snGDW15Xq+fX595XXrN4k6UtT4J9RvskcLu3Ow
   m7ZjdHzdBQaNOGQw7nvLZTCl3r0jwfrNmbGN5hbIE8mt2sYfgm/EHCqiR
   haVEKfUEuypPII+RWL8TI1aJtwrk+LpQ1I3Z1VScrHjvkfyrX3kOjmY81
   B0qoYuJ1dayLWy7d8BexSxZb4rRYbE8kY5h5vPx84KUPmWcQOHfRLRHbC
   3iicSo3KE2N8+1W9Q8jwP2Cu6WmYN+D35ijAZ59tTL7dektPhdA9qNln2
   urpij/U7XOYmXLQAC236f4HtuJA5hSwPB7LhPaMicatJc6V9QEPzFTNPj
   w==;
X-CSE-ConnectionGUID: 5Miof4nJQRqz+0ysRiVCsw==
X-CSE-MsgGUID: rNVAqRo/R2C9UvBwJpvPfA==
X-IronPort-AV: E=Sophos;i="6.27,237,1787011200"; 
   d="scan'208";a="35231788"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 22:23:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:9580]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.116:2525] with esmtp (Farcaster)
 id 67b814c5-46e7-4b55-900a-8dc4db453fb4; Fri, 27 Nov 2026 22:23:50 +0000 (UTC)
X-Farcaster-Flow-ID: 67b814c5-46e7-4b55-900a-8dc4db453fb4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 27 Nov 2026 22:23:50 +0000
Received: from dev-dsk-surenkj-2b-416930d2.us-west-2.amazon.com (10.169.26.94)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 27 Nov 2026 22:23:49 +0000
From: Surendran Kanagaraj <surenkj@amazon.com>
To: <jarkko@kernel.org>
CC: <corbet@lwn.net>, <graf@amazon.de>, <gunnarku@amazon.com>, <jgg@ziepe.ca>,
	<joshlev@amazon.com>, <leitao@debian.org>, <linux-doc@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <noodles@earth.li>, <peterhuewe@gmx.de>,
	<rdunlap@infradead.org>, <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v4 1/8] tpm: Add a single table for all TPM wait limits
Date: Fri, 27 Nov 2026 22:23:47 +0000
Message-ID: <20261127222347.92729-1-surenkj@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awiCQCU-h8MQc6bQ@kernel.org>
References: <awiCQCU-h8MQc6bQ@kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Nov 26, 2026 at 09:02:24PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 25, 2026 at 11:00:34PM +0000, Surendran Kanagaraj wrote:
> > 2) Keep the chip durations in a union of TPM1.x and TPM2.0 durations.
> >
> >      union tpm_durations {
> >              unsigned long tpm1[TPM1_NUM_DURATIONS];
> >              struct tpm2_ordinal_duration tpm2[TPM2_NUM_DURATIONS];
> >      };
> >
> >    struct tpm_chip holds the union tpm_durations in place of
> >    chip->duration[]
>
> It isn't possible to have single struct tpm duration that is partially
> used by TPM1?

Yes, that should work. Something like this:

	struct tpm_cmd_duration {
		/* TPM 2.0: command code or TPM 1.x: duration class */
		u32 cmd;
		u32 duration;	/* msecs */
	};

	/* in struct tpm_chip, in place of chip->duration[] */
	struct tpm_cmd_duration durations[TPM_MAX_DURATIONS];

eg:
	/* TPM 1.x */
	chip->durations[0] = { TPM_SHORT, 750 }

	/* TPM 2.0 */
	chip->durations[2] = { TPM2_CC_GET_RANDOM, 2000 }

Does this match what you had in mind?

Thanks,
Surendran
