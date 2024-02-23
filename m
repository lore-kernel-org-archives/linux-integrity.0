Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E79085268
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713036; cv=none; b=qEfEnNVkNn/ipQ8QOmE98dR+0mZiT1eMU4gpNZ39ebAElgjLRGbc90kQGK3h3zk8kI7MwbtlXX3d1wk20irdhtGoOZgNWLyibZ6xEPT+wS5J32qTnOI0PyT8VZNIJw6q5/z+39Gv7Y8Y1kuqqdYTIQRCRLb+n9UhCmCl3PqmJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713036; c=relaxed/simple;
	bh=KLA/xC9eu5I2mAql6hJ4M6fAT/tSIrws/oVT+ANgLCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prihqJu5jslFOUF6eQj1Gw/BUqa+rxvWDb+vg1nVOT/5Kbqkl1xzvQYlFENt89vThxe5bbKkQv4zN8vaCyJLdPzf/uzce9q/d9i/48U39WqZn992283xcBjTaWiG+/lg4Ts6rsMrXsfVa0g1OVGBBdOeSyGzf+YVR0s/bEA74xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 8562772C8FB;
	Fri, 23 Feb 2024 21:30:22 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 6E3EC36D016F;
	Fri, 23 Feb 2024 21:30:22 +0300 (MSK)
Date: Fri, 23 Feb 2024 21:30:21 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, a.mardegan@omp.ru, git@andred.net,
	dbaryshkov@gmail.com, ebiggers@google.com, sorenson@redhat.com,
	gcwilson@linux.ibm.com, James.Bottomley@HansenPartnership.com,
	kgoldman@us.ibm.com, mjg59@srcf.ucam.org, zohar@linux.ibm.com,
	patrick.ohly@intel.com, patrick@puiterwijk.org,
	petr.vorel@gmail.com, roberto.sassu@huawei.com,
	stefanb@linux.ibm.com, stephen.smalley.work@gmail.com,
	tianjia.zhang@linux.alibaba.com, vgoyal@redhat.com,
	z.jasinski@samsung.com
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <20240223183021.dmfaqobbbkzblqsn@altlinux.org>
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>

On Wed, Feb 21, 2024 at 10:11:34AM +0200, Dmitry Kasatkin wrote:
> Currently libimaevm provided by this project is used by the tool evmctl,
> which is also provided by this project.
> 
> An issue was reported about using libimaevm with other software. Its
> GPL2-only license makes it incompatible to use with other licenses, in
> particular GPL3-only.
> 
> To address this issue, change the project license to GPL-2.0-or-later
> and libimaevm to LGPL 2.0 or later.

Acked-by: Vitaly Chikunov <vt@altlinux.org>

Thanks,

