Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFA3E1688
	for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534664; cv=none; b=Ka2l3pjIK/VQoW9MpTd+LJEGZzR+cY8TMVdQTGKWQX2UKawnWj3G5Ti8ZwwmqS99myMPFMWQf3+CB1E2IaQBrhORqMnGvRUUTPxLWV4R5D4atTjhZq/4MHj6oeTn5ikZ0vFEQsM/d+OUOlCgqUajQTLreQuP4xUaSl9ZZWo1y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534664; c=relaxed/simple;
	bh=DIFxmRnwufPE43JRiH6E4AfHlHo9hVO52fExH+S+rK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo3q9uVXfZRWxVWQyw8Xvw+5F79wmoh3WXpnCz65nVU0a/RzxD6PAjKOfuyxlLciLo0AUIg9jwWppJH1ieQczVvpSUDzMuRUFk8cDC518V1rDpTYHU7CzL3cFYtRprL75gbi1AiXTE4LGys3XbdeNmdzLbcswCcuKOuJZ9zdnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-53506b44151so57891361cf.0
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2026 01:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534662; x=1792139462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIf3Kb4v9Q13a/WyDvBX8cPlNPGYJMWyM06g7YQDej8=;
        b=olGUkviAEIYG8IhJXO/Qykeq7WGzy8p/vXXtafJ9vFh+4LnPBrRqFOXjC8wWtJ1YVS
         U3B+xHw6cRyfAt9ESOZQUJ6BooqsKqU7PcjYiPX0FigzdlHTW5LaOrE87y+ZuFIGoMU+
         SjZbxSvdb3Va28Z92WQExxw2P2JT94It/76YQEsw2+WgtKl6mDxF6Rx7/OpEFzMVHqb7
         k28MoI3kpoBQEUjGwe/Grl2g7JhbchTJ3cXklFKF4+KGo3FOnVUSqeZNtv3yFxhVtf2n
         IOhn5m79tTzDNTjaNo9l4wDsUpdauDk/hGxZvJLoqCPuy90Q6z1VFkqJZ4vIPmWJfJ8l
         7DGw==
X-Forwarded-Encrypted: i=1; AKwUvBzxpgcctZcT5acHmfjBU7E1jdSueiJcPIf4sMHcMEo3sbF19tlhLmTnjWMfhfds9aBvuvfbqhxHaBvuZctQJXA=@vger.kernel.org
X-Gm-Message-State: AFuF++l9iIJonlgq6aPLdJfkH5r8HtocWhPNOucCgFdiKXULJB38f6hu
	fUHZoylXOCwxhtAl8Wz2ELx4jSvOoE0jXAt38x6n09q9H2n7o+fW5ezHNuDGJEzv8kkFzKAjHRl
	OR6iENvmxjoQpvhn1/yo9wmQEAL1mP1xX8VENDVwUNMzlToI1cqti
X-Gm-Gg: AYBFou3zKjo0+RFAS6sBGIrskx5g0WOnc3fe7nFZ7h7/8ge5vi2WMkXuEPNAFkgVc7T
	N6afMAzudDfK9v3fX6N4NO6yge/jFbVp+jayPZF0i7cu9iqqYtOVcfEdaFkRbiQpLiGgSkt5ZqT
	br0NXqejtBoJ/eZSOsDdxIoUasY+ZD/PWQ6omEpHi6z2ZPqTF4zwP87ww+RsqXKBojdg8nnI351
	kQJ5sA/3X7sDjZRDNzO7+cx8CSZGscHjiGH1/jj6miTojpHsjlhu8vCxY7d5wU37wTI0F31jm/1
	nXexYjL9HxQSyvClCk53pVmgeAARs4xAKETgLnOhQSnEyi8rI/3Va4c5MzrmFP9KU8WTmvBbmzp
	eSjs=
X-Received: by 2002:ac8:5a92:0:b0:533:340e:7483 with SMTP id d75a77b69052e-5359f488e55mr18513871cf.5.1791534662295;
        Fri, 09 Oct 2026 01:31:02 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5359b7dcf1dsm79991cf.37.2026.10.09.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:31:02 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1E60A12862D5; Fri, 09 Oct 2026 01:31:01 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:31:01 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 17/17] PM: hibernate: Allow hibernation under lockdown
 with signed images
Message-ID: <asimRSqckPDUl0A8@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-18-matthewg@nvidia.com>
 <asfKpInP6j8DYA4-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asfKpInP6j8DYA4-@kernel.org>

On Thu, Oct 08, 2026 at 07:53:56PM +0300, Jarkko Sakkinen wrote:

> I skimmed the rest of the patches but gave up for now given time and
> bandwidth, and also having quite loose grip to the changes until I
> run them (it's just complex patch set enough).
> 
> What kind of test environment you have in high-level, or could you
> give some rough guidelines for a test environment?
> 
> I'm thinking of setting up something with Buildroot, QEMU and swtpm
> perhaps.

Testing has been qemu + swtpm, with some scripts to build a toy 
initramfs to automatically do the testing. What would be the best way to 
share those with you?
