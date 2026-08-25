Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8C357CFC
	for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676430; cv=none; b=bzoEcsXncKMjfV2krUTqW/TO83h3EoU8CZxIr0nxB0CiMXw2CmLX0EZPz03j/yuz35cTPaGhbXwcs9mcM4p9/P3SEXmDYQ2J8U4xMXIhIdcwdJQk5FCHpazwtE+aZitjuQmfgMwa6/RPMp3lgYAmpvue1EbML5K6JPOrlhuVlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676430; c=relaxed/simple;
	bh=Q5RlCcycfNc2TZ/PvLCKqaWXfCM1b94KP4InGT6cXWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obG0rU8l+180Y/+YFt9E0HZuhZfIX8Yz1yPdK5152ChwuHhIGxTeia/zI5kDmd01TX31Mg/ON5tPEEgzz0PPs4046q47rOBD2tAwNk/m3FyUf+W6RlJrypEeZIpnPds9GK3R8flL7I+iJtYDXorm218lXbZpEIYLbYe1Qu7/pXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CTsPnkvf; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CTsPnkvf"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66ce5312ca6so13755d50.0
        for <linux-integrity@vger.kernel.org>; Tue, 25 Aug 2026 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787676428; x=1788281228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7t5uDlAobliWG5HjrlwdWCEo0ZIR1xcFmgey215k/k=;
        b=CTsPnkvf0m3sqQspkwWMq4D5A/GGYn8KzLNyWRisJVRFRVoZh6Yh3INW9orlTdvr2E
         vW8HisecWBMfGuV27vMC/k/Y5ZW/EqAe5cYVKiADRDKKHev275E8+FT737YEy8d6ij+u
         TvNcoEW40FrgjLQbIQM6jJUlAB2cdnBAMFzLCeOnLIHRlW1UoJA6obrsi8KHy6C9Svnm
         oI4/1qu/paodGaTq7/3Wfr9wgA56kmFvNBuDwYiVp8E+8HGnx+0pz4MRh+UMwaJkz0mh
         okLoVfynBFUlGwmxjpI6uhDFGBZA2cykAZH/J1SDAQv3ggRGdLB5AGzF3Uhkk5gf3KvC
         l96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787676428; x=1788281228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7t5uDlAobliWG5HjrlwdWCEo0ZIR1xcFmgey215k/k=;
        b=FtFpCmbzNPWzlfeVDd9Nj4xQGYf2CFF6ONl78qhW9sCDNJC1yMXMKHoDRnP/879cNh
         krLDKIpY0RkT23rpqIxWy/mLGJ8LhLvLsZNCvkeL89nX031zgFTCSFvoQoW8uXjInvSW
         MDvhx+MJh2RLkkQiOoUa7IQAP8ijmn5VJs/SXuxFyIpo63OAGF1tAAsC0d7eirtBtJC9
         EEtQDg95cpurhBHo8hs6c/4UzV2WDtJ6IOdyM39QXFCdMHVie5feX8RbIH43vEshl4MR
         zUYWJgZjaE5e4NxsFam9t+tFtgT4JVlhRMa/ew9v5EJzk9IexLe8flm8YpM5JyD4fPXA
         ISKw==
X-Forwarded-Encrypted: i=1; AHgh+Rps9qU2g5UAJ/Vfgeia8Aewz9pU0bRwUOnFdr/7BZ6SpWiXxkugon4rICW+7Km4ooG1mZvKFxqAmSuMaK+XCpg=@vger.kernel.org
X-Gm-Message-State: AFuF++mjq0+wT0Dl03hIsKAvSBYum73i5svrV80MZ96f1qSg46PUqZke
	skX6NWeAI2+GhHRs5mmCQY6OLZm2rG3IHfBXBnzHC9kydyoYvzPcAR0vXZ8+B0lKOIk=
X-Gm-Gg: AR+sD10iGKteTeXadPPZW6axaX9M/0lvYIZomkrhMPKt6JOHIVW5NFtiIsyJhAd/mvY
	a6KPDy6WaBL8HwRPz4/QugalreptKiSrLb0hmVj4E6RaFkYN20NW4NjnSy1pKNXTsRWB+kSQwrs
	qd3K6sxLE/jkGIQYyGkKaJIcAaCzO3/TpfMfY8Chk1rNZeYbbX4OTBld/QRCcmxigoXiE/3GImo
	8O+EwN1Db8kU27RwP+xwWNdLDqoiLO/jBfzX4OnhejkFGhl2k/qDNUkqTTpk3r0lW22TqZLg13a
	UZ9aP4FI9yXnjPIY1vNT9WF0MP665ZlaeOdgLc/y4mwljbs6T4iM5TcAZq06XAHRlw4UltEERpn
	Ey1HW/8nFMsIpBqefLqD+vf3I214fK7v8drjop+LERKa6zyRCnKbJTNOADfTB/PVCAw4U7s3O1O
	03z81Q6fh6I4sG1G4ml9kk0zfqSgK4EA1iOzOBDSg=
X-Received: by 2002:a05:690e:e26:b0:667:f9cd:6ba4 with SMTP id 956f58d0204a3-66d256656a7mr11937d50.2.1787676427852;
        Tue, 25 Aug 2026 09:47:07 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac6:947f:3af::5e:70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d2454d92asm262019d50.3.2026.08.25.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:47:07 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:47:04 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v2 1/2] configfs: move CONFIGFS_MAGIC definition to
 magic.h
Message-ID: <6k67quhqhibslnmavtbvgnlzbohpgmyfm4yxekl4k5lzqdvr5o@xg3wbmdl5wbt>
References: <20260819-configfs-v2-0-cb6e65d11589@cloudflare.com>
 <20260819-configfs-v2-1-cb6e65d11589@cloudflare.com>
 <ao2iHWDZAJf0FRqh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao2iHWDZAJf0FRqh@gmail.com>

Hi Breno,

On Tue, Aug 25, 2026 at 07:10:02AM -0700, Breno Leitao wrote:
> On Wed, Aug 19, 2026 at 06:45:22PM -0500, Frederick Lawler wrote:
> > IMA shouldn't measure or appraise configfs, but currently does because
> > it's missing from the default exclusion policies. Move CONFIGFS_MAGIC to
> > magic.h to expose the file system's magic to IMA, as well as other userland
> > applications.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> 
> Do you want this change to go thorugh the configfs tree, or the tree
> specific for IMA?
> ?

Unless you have a user asking for it, I personally think it makes sense
for linux-integrity to take it since the two patches are related.

I don't mind spinning a v3 for integrity if you choose to take it now.

Best,
Fred

PS. Sorry for not keeping the Reviewed-by tag from v1. I usually
forget _something_ with re-spins until after the fact.
